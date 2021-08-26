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

ActiveRecord::Schema.define(version: 2021_08_25_234251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "polls", force: :cascade do |t|
    t.string "question"
    t.string "options", default: [], array: true
    t.string "recipient_numbers", default: [], array: true
    t.string "sender_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "received_votes", default: [], array: true
  end

  create_table "sms_conversations", force: :cascade do |t|
    t.string "twilio_number"
    t.string "recipient"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
