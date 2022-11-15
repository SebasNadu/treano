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

ActiveRecord::Schema[7.0].define(version: 2022_11_14_223142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "challenge_name"
    t.integer "treanos"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_items", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.string "listable_type", null: false
    t.bigint "listable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_items_on_list_id"
    t.index ["listable_type", "listable_id"], name: "index_list_items_on_listable"
  end

  create_table "lists", force: :cascade do |t|
    t.string "list_name"
    t.integer "votes"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "public", default: true
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "media_providers", force: :cascade do |t|
    t.bigint "provider_id", null: false
    t.string "providable_type", null: false
    t.bigint "providable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["providable_type", "providable_id"], name: "index_media_providers_on_providable"
    t.index ["provider_id"], name: "index_media_providers_on_provider_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "country_of_origin"
    t.text "overview"
    t.date "release_date"
    t.string "poster_url"
    t.float "rating_average"
    t.integer "tmdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "backdrop_url"
  end

  create_table "providers", force: :cascade do |t|
    t.string "provider_name"
    t.string "logo_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ios_appstore_url"
    t.string "android_playstore_url"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.bigint "user_id", null: false
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.integer "tmdb_review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "saved_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_saved_lists_on_list_id"
    t.index ["user_id"], name: "index_saved_lists_on_user_id"
  end

  create_table "tvs", force: :cascade do |t|
    t.string "title"
    t.text "overview"
    t.string "country"
    t.date "first_air_date"
    t.integer "tmdb_id"
    t.string "backdrop_url"
    t.string "poster_url"
    t.float "rating_average"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_challenges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_user_challenges_on_challenge_id"
    t.index ["user_id"], name: "index_user_challenges_on_user_id"
  end

  create_table "user_providers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "provider_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_user_providers_on_provider_id"
    t.index ["user_id"], name: "index_user_providers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "country"
    t.text "bio"
    t.integer "reputation_score"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "list_items", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "media_providers", "providers"
  add_foreign_key "reviews", "users"
  add_foreign_key "saved_lists", "lists"
  add_foreign_key "saved_lists", "users"
  add_foreign_key "user_challenges", "challenges"
  add_foreign_key "user_challenges", "users"
  add_foreign_key "user_providers", "providers"
  add_foreign_key "user_providers", "users"
end
