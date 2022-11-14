class CreateTvs < ActiveRecord::Migration[7.0]
  def change
    create_table :tvs do |t|
      t.string :title
      t.text :overview
      t.string :country
      t.date :first_air_date
      t.integer :tmdb_id
      t.string :backdrop_url
      t.string :poster_url
      t.float :rating_average
      t.timestamps
    end
  end
end
