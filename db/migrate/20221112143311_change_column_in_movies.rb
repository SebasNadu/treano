class ChangeColumnInMovies < ActiveRecord::Migration[7.0]
  def change
    rename_column :movies, :original_title, :title
  end
end
