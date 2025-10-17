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

ActiveRecord::Schema[8.0].define(version: 2025_10_18_194942) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "pages"
    t.text "description"
    t.string "url"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "completion_date"
    t.integer "challenge_id", null: false
    t.index ["challenge_id"], name: "index_books_on_challenge_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "challenge_participations", force: :cascade do |t|
    t.integer "challenge_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invited_by_id"
    t.index ["challenge_id", "user_id"], name: "index_challenge_participations_on_challenge_id_and_user_id", unique: true
    t.index ["challenge_id"], name: "index_challenge_participations_on_challenge_id"
    t.index ["invited_by_id"], name: "index_challenge_participations_on_invited_by_id"
    t.index ["user_id"], name: "index_challenge_participations_on_user_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.date "due_date", null: false
    t.integer "veto_threshold", default: 1, null: false
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_challenges_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "veto_reason"
    t.index ["book_id"], name: "index_votes_on_book_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "books", "challenges"
  add_foreign_key "books", "users"
  add_foreign_key "challenge_participations", "challenges"
  add_foreign_key "challenge_participations", "users"
  add_foreign_key "challenge_participations", "users", column: "invited_by_id"
  add_foreign_key "challenges", "users", column: "creator_id"
  add_foreign_key "votes", "books"
  add_foreign_key "votes", "users"
end
