class CreateUserStreamingPlatforms < ActiveRecord::Migration[7.0]
  def change
    create_table :user_streaming_platforms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :streaming_platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
