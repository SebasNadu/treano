class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :provider_name
      t.string :logo_path
      t.integer :tmdb_provider_id

      t.timestamps
    end
  end
end
