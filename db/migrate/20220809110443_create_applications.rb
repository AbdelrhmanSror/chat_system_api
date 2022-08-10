class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :password_reset_token

      t.timestamps
    end
    add_index :applications, :password_reset_token, unique: true
  end
end
