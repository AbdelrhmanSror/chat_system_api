class AddApplicationIdToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :application_id, :integer
  end
end
