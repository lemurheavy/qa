require_dependency 'slugger'
require_dependency 'voteable'

class Question < ActiveRecord::Base
  include QA::Slugger
  include QA::Voteable

  has_many :answers
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :last_active_user, class_name: 'User', foreign_key: 'last_active_user_id'
  belongs_to :user

  default_scope { order('questions.created_at DESC') }

  validates_length_of :title, within: 10..150
  validates_presence_of :body, :title, :last_active_user_id, :last_active_at
  validate :tags_exist

  is_slugged :title

  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tags_exist
    self.errors.add(:tag_list, 'Question must be tagged') if self.tags.empty?
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def update_last_activity(user)
    self.last_active_user = user
    self.last_active_at = DateTime.current
  end

  def viewed_by(key)
    $view.sadd("question-#{self.id}", key)
  end

  def view_count
    $view.scard("question-#{self.id}")
  end

  def votes_on_self_and_answers_by_user(user)
    return [] if user == nil
    votes = self.votes.where(user_id: user.id)
    self.answers.includes(:votes).where('votes.user_id = ?', user.id).references(:votes).each do |answer|
      votes += answer.votes
    end
    votes
  end
end