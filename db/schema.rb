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

ActiveRecord::Schema.define(version: 20170209192236) do

  create_table "bet_options", force: :cascade do |t|
    t.text     "option_text"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "winner",      default: false
  end

  create_table "bets", force: :cascade do |t|
    t.text     "bet"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  create_table "debts", force: :cascade do |t|
    t.integer  "debtor_id"
    t.integer  "creditor_id"
    t.decimal  "amount",      precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["creditor_id"], name: "index_debts_on_creditor_id"
    t.index ["debtor_id"], name: "index_debts_on_debtor_id"
  end

  create_table "user_bets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bet_id"
    t.decimal "amount_bet",    precision: 10, scale: 2
    t.integer "bet_option_id"
    t.index ["bet_id"], name: "index_user_bets_on_bet_id"
    t.index ["bet_option_id"], name: "index_user_bets_on_bet_option_id"
    t.index ["user_id"], name: "index_user_bets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.text   "avatar"
    t.string "password_digest"
  end

end
