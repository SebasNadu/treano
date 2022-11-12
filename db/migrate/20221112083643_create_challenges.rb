class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :challenge_name
      t.integer :treanos
      t.boolean :completed

      t.timestamps
    end
  end
end
