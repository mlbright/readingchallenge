class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :user_id, uniqueness: { scope: :book_id, message: "has already vetoed this book" }
  validates :veto_reason, presence: true, length: { minimum: 10, maximum: 500 }
  
  # Prevent users from vetoing their own books
  validate :cannot_veto_own_book
  
  private
  
  def cannot_veto_own_book
    if book && user_id == book.user_id
      errors.add(:base, "You cannot veto your own book")
    end
  end
end
