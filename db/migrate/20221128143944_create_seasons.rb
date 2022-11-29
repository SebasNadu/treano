class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.date :air_date
      t.integer :episode_count
      t.integer :tmdb_id
      t.string :name
      t.string :overview
      t.string :poster_path
      t.integer :season_number
      t.references :tv, null: false, foreign_key: true

      t.timestamps
    end
  end
end
