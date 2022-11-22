class RemoveTrailerUrlFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :trailer_url, :string
  end
end
