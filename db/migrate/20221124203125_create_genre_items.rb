class CreateGenreItems < ActiveRecord::Migration[7.0]
  def change
    create_table :genre_items do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :genreable, null: false, polymorphic: true
      t.timestamps
    end
  end
end
