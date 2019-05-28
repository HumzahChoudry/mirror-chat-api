class Chat < ApplicationRecord
  has_many :messages
  has_many :user_chats
  belongs_to :chat_type
  has_many :users, through: :user_chats
  belongs_to :admin, class_name: "User"

  def message_with_usernames
    self.messages.map { |message|
      message.slice(:id, :username, :content, :chat_id, :created_at)
    }
  end
end
