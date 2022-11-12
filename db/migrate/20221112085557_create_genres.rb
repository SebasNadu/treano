class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :genre_name
      t.integer :tmdb_genre_id

      t.timestamps
    end
  end
end
