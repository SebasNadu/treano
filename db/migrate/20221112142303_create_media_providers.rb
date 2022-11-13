class CreateMediaProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :media_providers do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :providable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
