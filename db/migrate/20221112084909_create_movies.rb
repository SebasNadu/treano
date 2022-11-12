class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :original_title
      t.string :country_of_origin
      t.string :trailer_url
      t.text :overview
      t.date :release_date
      t.string :poster_url
      t.string :tagline
      t.float :rating_average
      t.integer :tmdb_id
      t.integer :imdb_id

      t.timestamps
    end
  end
end
