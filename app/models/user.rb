class User < ApplicationRecord
  has_secure_password validations: false

  has_many :books, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :created_challenges, class_name: "Challenge", foreign_key: "creator_id", dependent: :destroy
  has_many :challenge_participations, dependent: :destroy
  has_many :challenges, through: :challenge_participations

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: -> { password.present? }
  validate :password_complexity, if: -> { password.present? }

  # Attribute to track if this is first login for password setup
  attr_accessor :pending_password_setup

  # Check if user can create more challenges
  def can_create_challenge?
    created_challenges.count < 100
  end

  # Get count of completed books
  def completed_books_count
    books.completed.count
  end

  # Get count of in-progress books
  def in_progress_books_count
    books.in_progress.count
  end

  # Get completed books for a specific challenge
  def completed_books_in_challenge(challenge)
    books.where(challenge: challenge).completed.count
  end

  # Check if user needs to set up password (created by admin)
  def needs_password_setup?
    password_digest.nil?
  end

  private

  def password_complexity
    return if password.blank?

    errors.add(:password, "must include at least one lowercase letter") unless password.match?(/[a-z]/)
    errors.add(:password, "must include at least one uppercase letter") unless password.match?(/[A-Z]/)
    errors.add(:password, "must include at least one digit") unless password.match?(/\d/)
    errors.add(:password, "must include at least one special character (!@#$%^&*()_+-=[]{}|;:,.<>?)") unless password.match?(/[!@#$%^&*()_+\-=\[\]{}|;:,.<>?]/)
  end
end
