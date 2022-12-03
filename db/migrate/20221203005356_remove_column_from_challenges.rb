class RemoveColumnFromChallenges < ActiveRecord::Migration[7.0]
  def change
    remove_column :challenges, :completed
  end
end
