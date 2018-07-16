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

ActiveRecord::Schema.define(version: 20180716004921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.text "player_1_board"
    t.text "player_2_board"
    t.integer "winner"
    t.integer "player_1_turns"
    t.integer "player_2_turns"
    t.integer "current_turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_1_destroyer_count", default: 1
    t.integer "player_1_cruiser_count", default: 1
    t.integer "player_2_destroyer_count", default: 1
    t.integer "player_2_cruiser_count", default: 1
  end

  create_table "user_games", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.integer "player", default: 0
    t.integer "player_ships", default: 2
    t.index ["game_id"], name: "index_user_games_on_game_id"
    t.index ["user_id"], name: "index_user_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "status", default: 0
    t.string "auth_token"
    t.string "activation_token"
    t.index ["activation_token"], name: "index_users_on_activation_token", unique: true
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
  end

  add_foreign_key "user_games", "games"
  add_foreign_key "user_games", "users"
end
