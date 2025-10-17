class User < ApplicationRecord
  has_secure_password
  
  has_many :books, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
