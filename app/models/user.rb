class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :messages
end
