class CreateKeywordItems < ActiveRecord::Migration[7.0]
  def change
    create_table :keyword_items do |t|
      t.references :keyword, null: false, foreign_key: true
      t.references :keywordable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
