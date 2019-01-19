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

ActiveRecord::Schema.define(version: 2018_10_06_163045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "winner_id", null: false
    t.bigint "loser_id", null: false
    t.integer "price_in_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loser_id"], name: "index_games_on_loser_id"
    t.index ["season_id"], name: "index_games_on_season_id"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.bigint "season_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_leaderboards_on_season_id"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "leaderboard_id"
    t.bigint "user_id"
    t.integer "win_count", default: 0, null: false
    t.integer "loss_count", default: 0, null: false
    t.integer "net_in_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leaderboard_id"], name: "index_records_on_leaderboard_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["status"], name: "index_seasons_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "games", "seasons"
  add_foreign_key "games", "users", column: "loser_id"
  add_foreign_key "games", "users", column: "winner_id"
  add_foreign_key "leaderboards", "seasons"
  add_foreign_key "records", "leaderboards"
  add_foreign_key "records", "users"
end
