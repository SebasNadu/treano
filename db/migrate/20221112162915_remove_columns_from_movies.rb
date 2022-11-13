class RemoveColumnsFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :trailer_url
    remove_column :movies, :tagline
    remove_column :movies, :imdb_id
  end
end
