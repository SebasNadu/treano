class CreateTvs < ActiveRecord::Migration[7.0]
  def change
    create_table :tvs do |t|
      t.string :title
      t.text :overview
      t.string :country
      t.date :start_date
      t.date :end_date
      t.integer :tmdb_id
      t.integer :imdb_id
      t.integer :number_of_seasons
      t.integer :number_of_episodes

      t.timestamps
    end
  end
end
