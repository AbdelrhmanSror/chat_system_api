class DropColumnMessageCountFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :message_count
  end
end
