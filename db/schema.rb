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

ActiveRecord::Schema[7.1].define(version: 2024_03_30_184055) do
  create_table "queries", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "text", null: false
    t.string "formatted_text", null: false
    t.text "json_format", size: :long, null: false, collation: "utf8mb4_bin"
    t.boolean "active", default: false
    t.boolean "draft", default: true
    t.integer "version", default: 0
    t.bigint "query_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["query_type_id"], name: "index_queries_on_query_type_id"
    t.check_constraint "json_valid(`json_format`)", name: "json_format"
  end

  create_table "query_types", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_query_types_on_name", unique: true
  end

  create_table "quizzes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "goal"
    t.string "instructions"
    t.text "quiz_data", size: :long, null: false, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "json_valid(`quiz_data`)", name: "quiz_data"
  end

  add_foreign_key "queries", "query_types"
end
