class ChangeChatNumberToMessageCount < ActiveRecord::Migration[7.0]
  def change
    change_table :applications do |t|
      t.rename :chat_number, :chat_count
    end
  end
end
