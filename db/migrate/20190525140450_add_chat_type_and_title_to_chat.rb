class AddChatTypeAndTitleToChat < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :chat_type_id, :integer
    add_column :chats, :title, :string
  end
end
