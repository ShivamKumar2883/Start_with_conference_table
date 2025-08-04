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

ActiveRecord::Schema[8.0].define(version: 2025_08_04_070742) do
  create_table "conferences", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "theme"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "image"
    t.string "status", default: "upcoming", null: false
    t.string "event_url"
    t.bigint "j_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_conferences_on_end_date"
    t.index ["j_user_id"], name: "index_conferences_on_j_user_id"
    t.index ["start_date"], name: "index_conferences_on_start_date"
    t.index ["status"], name: "index_conferences_on_status"
    t.index ["title"], name: "index_conferences_on_title"
  end

  create_table "delayed_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "j_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "content", null: false
    t.bigint "j_user_id", null: false
    t.string "posted_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["j_user_id"], name: "index_posts_on_j_user_id"
  end

  create_table "profile_pictures", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "image_url"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_pictures_on_profile_id"
  end

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "designation"
    t.string "address"
    t.string "phone_number"
    t.string "profile_pic"
    t.string "pincode"
    t.bigint "j_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["j_user_id"], name: "index_profiles_on_j_user_id"
  end

  add_foreign_key "conferences", "j_users"
  add_foreign_key "posts", "j_users"
  add_foreign_key "profile_pictures", "profiles"
  add_foreign_key "profiles", "j_users"
end
