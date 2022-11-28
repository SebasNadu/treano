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

ActiveRecord::Schema[7.0].define(version: 2022_11_28_145434) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "challenges", force: :cascade do |t|
    t.string "challenge_name"
    t.integer "treanos"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favoritable_type", null: false
    t.bigint "favoritable_id", null: false
    t.string "favoritor_type", null: false
    t.bigint "favoritor_id", null: false
    t.string "scope", default: "favorite", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked"], name: "index_favorites_on_blocked"
    t.index ["favoritable_id", "favoritable_type"], name: "fk_favoritables"
    t.index ["favoritable_type", "favoritable_id", "favoritor_type", "favoritor_id", "scope"], name: "uniq_favorites__and_favoritables", unique: true
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
    t.index ["favoritor_id", "favoritor_type"], name: "fk_favorites"
    t.index ["favoritor_type", "favoritor_id"], name: "index_favorites_on_favoritor"
    t.index ["scope"], name: "index_favorites_on_scope"
  end

  create_table "genre_items", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.string "genreable_type", null: false
    t.bigint "genreable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_items_on_genre_id"
    t.index ["genreable_type", "genreable_id"], name: "index_genre_items_on_genreable"
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name"
    t.integer "tmdb_genre_id"
    t.integer "watchmode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keyword_items", force: :cascade do |t|
    t.bigint "keyword_id", null: false
    t.string "keywordable_type", null: false
    t.bigint "keywordable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_keyword_items_on_keyword_id"
    t.index ["keywordable_type", "keywordable_id"], name: "index_keyword_items_on_keywordable"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.integer "tmdb_id"
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
    t.string "ios_url"
    t.string "android_url"
    t.string "web_url"
    t.string "name"
    t.string "region"
    t.string "format"
    t.float "price"
    t.integer "seasons"
    t.integer "episodes"
    t.index ["providable_type", "providable_id"], name: "index_media_providers_on_providable"
    t.index ["provider_id"], name: "index_media_providers_on_provider_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "overview"
    t.date "release_date"
    t.string "poster_url"
    t.float "rating_average"
    t.bigint "tmdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "backdrop_url"
    t.string "tagline"
    t.string "homepage"
    t.string "trailer"
    t.integer "year"
    t.integer "runtime"
    t.bigint "revenue"
    t.bigint "budget"
    t.string "status"
    t.string "original_language"
    t.integer "critic_score"
    t.text "genre_names", array: true
    t.text "similar_titles_watchmode", array: true
    t.text "recommendations_tmdb", array: true
    t.string "us_rating"
    t.float "popularity"
    t.bigint "watchmode_id"
    t.string "imdb_id"
  end

  create_table "providers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ios_appstore_url"
    t.string "android_playstore_url"
    t.string "name"
    t.string "logo_url"
    t.text "regions", array: true
    t.integer "watchmode_id"
    t.string "service"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "rating"
    t.text "content"
    t.bigint "user_id", null: false
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.string "tmdb_review_id"
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

  create_table "seasons", force: :cascade do |t|
    t.date "air_date"
    t.integer "episode_count"
    t.integer "tmdb_id"
    t.string "name"
    t.string "overview"
    t.string "poster_path"
    t.integer "season_number"
    t.bigint "tv_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_id"], name: "index_seasons_on_tv_id"
  end

  create_table "tvs", force: :cascade do |t|
    t.string "title"
    t.text "overview"
    t.date "first_air_date"
    t.integer "tmdb_id"
    t.string "backdrop_url"
    t.string "poster_url"
    t.float "rating_average"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "homepage"
    t.date "last_air_date"
    t.string "trailer"
    t.integer "number_of_episodes"
    t.integer "number_of_seasons"
    t.integer "runtime"
    t.string "original_language"
    t.float "popularity"
    t.integer "critic_score"
    t.string "us_rating"
    t.integer "year"
    t.string "status"
    t.string "tagline"
    t.integer "watchmode_id"
    t.string "imdb_id"
    t.string "recommendations_tmdb", array: true
    t.string "similar_titles_watchmode", array: true
    t.string "genre_names", array: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "genre_items", "genres"
  add_foreign_key "keyword_items", "keywords"
  add_foreign_key "list_items", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "media_providers", "providers"
  add_foreign_key "reviews", "users"
  add_foreign_key "saved_lists", "lists"
  add_foreign_key "saved_lists", "users"
  add_foreign_key "seasons", "tvs"
  add_foreign_key "user_challenges", "challenges"
  add_foreign_key "user_challenges", "users"
  add_foreign_key "user_providers", "providers"
  add_foreign_key "user_providers", "users"
end
