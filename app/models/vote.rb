class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :user_id, uniqueness: { scope: :book_id, message: "has already voted on this book" }
  validates :approved, inclusion: { in: [true, false] }
  
  # Prevent users from voting on their own books
  validate :cannot_vote_on_own_book
  
  private
  
  def cannot_vote_on_own_book
    if book && user_id == book.user_id
      errors.add(:base, "You cannot vote on your own book")
    end
  end
end
