class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :tmdb_id

      t.timestamps
    end
  end
end
