class AddDefaultForChatType < ActiveRecord::Migration[5.2]
  def change
    change_column :chats, :chat_type_id, :integer, :default => 1
  end
end
