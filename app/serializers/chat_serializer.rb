class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title, :chat_type, :messages, :users

  def messages
    #only grabbing last 50 messages, will work faster and can lazy load for more messages 
    self.object.messages.map { |m| {username: m.user.username, content: m.content} }
  end

end
