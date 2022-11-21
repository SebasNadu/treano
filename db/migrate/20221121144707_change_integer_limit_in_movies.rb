class ChangeIntegerLimitInMovies < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :tmdb_id, :integer, limit: 8
    change_column :movies, :revenue, :integer, limit: 8
    change_column :movies, :budget, :integer, limit: 8
    change_column :movies, :watchmode_id, :integer, limit: 8
  end
end
