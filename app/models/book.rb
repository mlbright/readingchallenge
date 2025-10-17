class Book < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  
  validates :title, presence: true
  validates :author, presence: true
  validates :pages, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(['http', 'https']), allow_blank: true }
  
  # Calculate if book is DISAPPROVED by majority
  def disapproved_by_majority?
    return false if votes.count == 0 # No votes means approved by default
    
    total_users = User.count
    return false if total_users <= 1 # If only the book owner exists
    
    # Check if majority of OTHER users disapprove
    other_users_count = total_users - 1
    disapproved_votes = votes.where(approved: false).count
    
    # If more than half of other users disapprove, book is disapproved
    disapproved_votes > (other_users_count / 2.0)
  end
  
  def approval_status
    disapproved_by_majority? ? "Disapproved by majority" : "Approved"
  end
end
