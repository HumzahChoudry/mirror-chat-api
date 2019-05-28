class MessageSerializer < ActiveModel::Serializer
  attributes :id, :username, :content

  def username
    self.user.username
  end
end
