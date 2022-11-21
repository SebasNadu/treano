class AddComplementToTvs < ActiveRecord::Migration[7.0]
  def change
    add_column :tvs, :homepage, :string
    add_column :tvs, :last_air_date, :date
    add_column :tvs, :trailer, :string
    add_column :tvs, :number_of_episodes, :integer
    add_column :tvs, :number_of_seasons, :integer
    add_column :tvs, :runtime, :integer
    add_column :tvs, :original_language, :string
    add_column :tvs, :popularity, :float
    add_column :tvs, :critic_score, :integer
    add_column :tvs, :us_rating, :string
    add_column :tvs, :year, :integer
    add_column :tvs, :status, :string
    add_column :tvs, :tagline, :string
    add_column :tvs, :watchmode_id, :integer
    add_column :tvs, :imdb_id, :string
    add_column :tvs, :recommendations_tmdb, :string, array: true
    add_column :tvs, :similar_titles_watchmode, :string, array: true
    add_column :tvs, :genre_names, :string, array: true
  end
end
