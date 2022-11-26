class ChangeRatingInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :rating, :float
    change_column :reviews, :tmdb_review_id, :string
  end
end
