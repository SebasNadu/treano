class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :reviewable, null: false, polymorphic: true
      t.integer :tmdb_review_id

      t.timestamps
    end
  end
end
