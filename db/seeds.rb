# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
g =User.create(username: "guy", password: "123", bio: "bio")
h = User.create(username: "humzah", password: "123", bio: "bio")
ct = ChatType.create(description: "public")
c = Chat.create(title: "Chatroom1", chat_type_id: ct.id)
UserChat.create(user_id: g.id, chat_id: c.id)
UserChat.create(user_id: h.id, chat_id: c.id)
Message.create(user_id: h.id, chat_id: c.id, content: "hello world!")
