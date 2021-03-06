class Vote < ActiveRecord::Base
  belongs_to :post, polymorphic: true
  belongs_to :user

  UPVOTE = 1
  DOWNVOTE = 2

  validates_presence_of :post_type, :post_id, :user_id, :vote_type_id
  validate :validate_one_updown_vote
  validate :validate_not_own_post

  after_save :update_post_vote_count
  after_destroy :update_post_vote_count

  def update_post_vote_count
    self.post.update_vote_count!
  end

  def validate_one_updown_vote
    if self.post.votes.where(user_id: self.user.id, vote_type_id: [1,2]).length > 0
      self.errors[:base] << 'Can only vote once on a post'
    end
  end

  def validate_not_own_post
    if self.post.user_id == self.user_id
      self.errors[:base] << 'You cannot vote on your own posts'
    end
  end
end