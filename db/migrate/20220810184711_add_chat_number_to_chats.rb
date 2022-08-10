class AddChatNumberToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :chat_number, :integer
    add_index :chats, :chat_number
  end
end
