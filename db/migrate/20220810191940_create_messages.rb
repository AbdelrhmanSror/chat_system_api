class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :message_count
      t.string :body
      t.integer :message_number
      t.integer :chat_id

      t.timestamps
    end
  end
end
