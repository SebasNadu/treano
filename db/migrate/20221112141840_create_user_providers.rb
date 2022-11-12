class CreateUserProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :user_providers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
