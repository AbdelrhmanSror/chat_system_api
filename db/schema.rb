# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_10_194720) do
  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "password_reset_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chat_count"
    t.index ["password_reset_token"], name: "index_applications_on_password_reset_token", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.integer "message_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "application_id"
    t.integer "chat_number"
    t.index ["application_id"], name: "index_chats_on_application_id"
    t.index ["chat_number"], name: "index_chats_on_chat_number"
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.integer "message_number"
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["message_number"], name: "index_messages_on_message_number"
  end

end
