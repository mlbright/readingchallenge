class ChallengeParticipation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  belongs_to :invited_by, class_name: 'User', optional: true
  
  validates :user_id, uniqueness: { scope: :challenge_id, message: "is already participating in this challenge" }
  validates :book_goal, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  before_validation :set_default_book_goal, on: :create
  
  private
  
  def set_default_book_goal
    self.book_goal ||= challenge.default_book_goal if challenge
  end
end
