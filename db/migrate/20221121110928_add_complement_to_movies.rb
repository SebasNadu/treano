class AddComplementToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :homepage, :string
    add_column :movies, :trailer, :string
    add_column :movies, :year, :integer
    add_column :movies, :runtime, :integer
    add_column :movies, :revenue, :integer
    add_column :movies, :budget, :integer
    add_column :movies, :status, :string
    add_column :movies, :original_language, :string
    add_column :movies, :critic_score, :integer
    add_column :movies, :genre_names, :text, array: true
    add_column :movies, :similar_titles_watchmode, :text, array: true
    add_column :movies, :recommendations_tmdb, :text, array: true
    add_column :movies, :us_rating, :string
    add_column :movies, :popularity, :float
    add_column :movies, :watchmode_id, :integer
    add_column :movies, :imdb_id, :string
  end
end
