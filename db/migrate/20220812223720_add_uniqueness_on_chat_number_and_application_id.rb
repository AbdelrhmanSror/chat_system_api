class AddUniquenessOnChatNumberAndApplicationId < ActiveRecord::Migration[7.0]
  def change
    add_index :chats, [:chat_number, :application_id], unique: true

  end
end
