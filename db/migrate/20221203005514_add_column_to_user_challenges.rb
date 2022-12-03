class AddColumnToUserChallenges < ActiveRecord::Migration[7.0]
  def change
    add_column :user_challenges, :completed, :boolean, default: false
  end
end
