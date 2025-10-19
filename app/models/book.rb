class Book < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :pages, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp([ "http", "https" ]), allow_blank: true }
  validate :completion_date_not_in_future

  # Scopes
  scope :completed, -> { where.not(completion_date: nil) }
  scope :in_progress, -> { where(completion_date: nil) }

  # Check if book is completed
  def completed?
    completion_date.present?
  end

  # Get count of veto votes
  def veto_count
    votes.count
  end

  # Check if book has been vetoed (has any veto votes)
  def vetoed?
    votes.any?
  end

  # Check if book exceeds the veto threshold for its challenge
  def exceeds_veto_threshold?
    challenge && veto_count >= challenge.veto_threshold
  end

  # Check if book counts towards challenge (completed and not vetoed beyond threshold)
  def counts_for_challenge?
    completed? && !exceeds_veto_threshold?
  end

  private

  def completion_date_not_in_future
    if completion_date.present? && completion_date > Date.today
      errors.add(:completion_date, "cannot be in the future")
    end
  end
end
