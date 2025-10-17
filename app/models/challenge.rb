class Challenge < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :challenge_participations, dependent: :destroy
  has_many :participants, through: :challenge_participations, source: :user
  has_many :books, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :due_date, presence: true
  validates :veto_threshold, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :due_date_in_future, on: :create
  
  # Check if challenge is complete (past due date)
  def complete?
    due_date < Date.today
  end
  
  # Check if challenge is active (not yet due)
  def active?
    due_date >= Date.today
  end
  
  private
  
  def due_date_in_future
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "must be in the future")
    end
  end
end
