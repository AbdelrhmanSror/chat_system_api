class AlterPasswordResetToken < ActiveRecord::Migration[7.0]
  change_table :chats do |table|
    table.change :password_reset_token, :string
  end
end
