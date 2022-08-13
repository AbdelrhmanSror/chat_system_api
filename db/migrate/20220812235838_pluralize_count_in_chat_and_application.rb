class PluralizeCountInChatAndApplication < ActiveRecord::Migration[7.0]
  def change
    change_table :applications do |t|
      t.rename :chat_count, :chats_count
    end
    change_table :chats do |t|
      t.rename :message_count, :messages_count
    end
  end
end
