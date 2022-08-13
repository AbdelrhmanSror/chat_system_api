class AddUniquenessOnMessageNumberAndChatId < ActiveRecord::Migration[7.0]
  def change
    add_index :messages, [:message_number, :chat_id], unique: true
  end
end
