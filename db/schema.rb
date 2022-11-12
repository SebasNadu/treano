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

ActiveRecord::Schema[7.0].define(version: 2022_11_12_085649) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "challenge_name"
    t.integer "treanos"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name"
    t.integer "tmdb_genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "list_name"
    t.integer "votes"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movie_lists", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_movie_lists_on_list_id"
    t.index ["movie_id"], name: "index_movie_lists_on_movie_id"
  end

  create_table "movie_platforms", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "streaming_platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_platforms_on_movie_id"
    t.index ["streaming_platform_id"], name: "index_movie_platforms_on_streaming_platform_id"
  end

  create_table "movie_reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.integer "tmdb_review_id"
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_reviews_on_movie_id"
    t.index ["user_id"], name: "index_movie_reviews_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "original_title"
    t.string "country_of_origin"
    t.string "trailer_url"
    t.text "overview"
    t.date "release_date"
    t.string "poster_url"
    t.string "tagline"
    t.float "rating_average"
    t.integer "tmdb_id"
    t.integer "imdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_saved_lists_on_list_id"
    t.index ["user_id"], name: "index_saved_lists_on_user_id"
  end

  create_table "streaming_platforms", force: :cascade do |t|
    t.string "provider_name"
    t.string "logo_path"
    t.integer "tmdb_provider_id"
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

  create_table "user_streaming_platforms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "streaming_platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["streaming_platform_id"], name: "index_user_streaming_platforms_on_streaming_platform_id"
    t.index ["user_id"], name: "index_user_streaming_platforms_on_user_id"
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

  add_foreign_key "lists", "users"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "movie_lists", "lists"
  add_foreign_key "movie_lists", "movies"
  add_foreign_key "movie_platforms", "movies"
  add_foreign_key "movie_platforms", "streaming_platforms"
  add_foreign_key "movie_reviews", "movies"
  add_foreign_key "movie_reviews", "users"
  add_foreign_key "saved_lists", "lists"
  add_foreign_key "saved_lists", "users"
  add_foreign_key "user_challenges", "challenges"
  add_foreign_key "user_challenges", "users"
  add_foreign_key "user_streaming_platforms", "streaming_platforms"
  add_foreign_key "user_streaming_platforms", "users"
end
