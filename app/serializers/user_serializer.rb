class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio
  has_many :chats, serializer: ChatSerializer

end
