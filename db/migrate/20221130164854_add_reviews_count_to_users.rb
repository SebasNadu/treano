class AddReviewsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reviews_count, :integer, null: true

    User.reset_column_information
    User.find_each do |u|
      User.reset_counters u.id, :reviews
    end
  end
end
