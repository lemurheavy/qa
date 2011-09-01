class Answer < ActiveRecord::Base
  has_paper_trail
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :votes, :as => "voteable"

  default_scope where(:deleted_at => nil)

  validates_presence_of :question_id
  validates_presence_of :user_id
  validates_length_of :body, :minimum => 30

  attr_accessible :body, :question_id, :user_id

  def self.deleted
    self.unscoped.where('deleted_at IS NOT NULL')
  end
end