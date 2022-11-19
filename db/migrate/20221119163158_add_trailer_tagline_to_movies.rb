class AddTrailerTaglineToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :trailer_url, :string
    add_column :movies, :tagline, :string
  end
end
