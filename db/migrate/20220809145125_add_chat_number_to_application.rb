class AddChatNumberToApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :chat_number, :integer
  end
end
