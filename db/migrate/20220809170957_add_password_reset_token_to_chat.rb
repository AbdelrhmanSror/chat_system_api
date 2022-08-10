class AddPasswordResetTokenToChat < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :password_reset_token, :integer
    add_index :chats, :password_reset_token
  end
end
