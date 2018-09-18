# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_18_161123) do

  create_table "account_types", force: :cascade do |t|
    t.string "name_account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.float "available_money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.integer "account_type_id"
    t.integer "currency_id"
    t.integer "bank_type_id"
    t.index ["account_type_id"], name: "index_bank_accounts_on_account_type_id"
    t.index ["bank_type_id"], name: "index_bank_accounts_on_bank_type_id"
    t.index ["currency_id"], name: "index_bank_accounts_on_currency_id"
    t.index ["profile_id"], name: "index_bank_accounts_on_profile_id"
  end

  create_table "bank_types", force: :cascade do |t|
    t.string "name_bank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name_currency"
    t.string "acronym"
    t.string "symbol"
    t.float "conversion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "name_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "inssuing_user_id"
    t.integer "receiving_user_id"
    t.float "amount_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_type_id"
    t.float "inssuing_user_balance"
    t.float "receiving_user_balance"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
