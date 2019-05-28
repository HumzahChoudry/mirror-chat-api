class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  def username
    self.user.username
  end
end
