class ChallengeParticipation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  belongs_to :invited_by, class_name: 'User', optional: true
  
  validates :user_id, uniqueness: { scope: :challenge_id, message: "is already participating in this challenge" }
end
