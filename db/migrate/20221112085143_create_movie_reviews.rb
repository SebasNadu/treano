class CreateMovieReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_reviews do |t|
      t.integer :rating
      t.text :content
      t.integer :tmdb_review_id
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
