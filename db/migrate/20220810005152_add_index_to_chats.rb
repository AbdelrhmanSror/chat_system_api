class AddIndexToChats < ActiveRecord::Migration[7.0]
  def change
    remove_column :chats, :application_id
    add_column :chats, :application_id, :integer
    add_index :chats, :application_id
  end
end
