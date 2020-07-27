# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_27_232312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frequencies", force: :cascade do |t|
    t.string "slug"
    t.integer "amount", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_date"
    t.index ["slug"], name: "index_frequencies_on_slug"
  end

  create_table "income_sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "NZD", null: false
    t.bigint "frequency_id"
    t.index ["frequency_id"], name: "index_income_sources_on_frequency_id"
    t.index ["user_id"], name: "index_income_sources_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "account"
    t.datetime "due_date"
    t.boolean "optional", default: false, null: false
    t.datetime "skipped_at"
    t.bigint "schedule_id"
    t.bigint "user_id", null: false
    t.bigint "frequency_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "NZD", null: false
    t.datetime "paid_at"
    t.index ["frequency_id"], name: "index_payments_on_frequency_id"
    t.index ["schedule_id"], name: "index_payments_on_schedule_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "payments", "frequencies"
  add_foreign_key "payments", "payments", column: "schedule_id"
  add_foreign_key "payments", "users"
end
