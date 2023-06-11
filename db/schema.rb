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

ActiveRecord::Schema.define(version: 2023_06_11_103453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dices", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "value"
    t.boolean "locked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_dices_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "statut"
    t.integer "turn"
    t.string "current_player"
    t.integer "sum"
    t.string "substatut"
  end

  create_table "players", force: :cascade do |t|
    t.string "pseudo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.integer "pv"
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  add_foreign_key "dices", "games"
  add_foreign_key "players", "games"
end
