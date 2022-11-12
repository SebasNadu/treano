class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.references :list, null: false, foreign_key: true
      t.references :listable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
