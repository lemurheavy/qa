class ReputationEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :reputable, :polymorphic => true
  
  # A reputation event represents something that caused the users rep to change
  # Upvote -> 1
  # Downvote -> 2
  
  after_save :refresh_reputation
  
  REPUTATION_VALUES = [
    { :name => :question_upvote, :value => 5 },
    { :name => :question_downvote, :value => -2 },
    { :name => :answer_upvote, :value => 10 },
    { :name => :answer_downvote, :value => -1 }
  ]

  validates_presence_of :reputable
  validates_presence_of :user
  validates_presence_of :value
  validates_numericality_of :value

  def refresh_reputation
    self.user.refresh_reputation
  end
end
