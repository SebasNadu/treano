class AddBackdropUrlToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :backdrop_url, :string
  end
end
