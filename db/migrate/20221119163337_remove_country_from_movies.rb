class RemoveCountryFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :country_of_origin, :integer
  end
end
