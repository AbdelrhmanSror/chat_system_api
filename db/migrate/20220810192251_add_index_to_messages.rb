class AddIndexToMessages < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, :message_number
    add_index :messages, :chat_id

  end
end
