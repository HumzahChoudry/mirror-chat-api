class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title, :chat_type, :messages, :users

  def messages
    self.object.messages.map { |m| {username: m.user.username, content: m.content} }
  end

end
