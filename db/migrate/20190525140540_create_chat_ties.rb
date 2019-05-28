class CreateChatTies < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
