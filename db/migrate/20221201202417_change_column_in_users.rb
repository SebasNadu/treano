class ChangeColumnInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :reputation_score, :integer, default: 0
  end
end
