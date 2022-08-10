class RemovePasswordResetTokenFromChat < ActiveRecord::Migration[7.0]
  def change
    remove_column :chats, :password_reset_token
  end
end
