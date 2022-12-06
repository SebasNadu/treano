class DropSavedLists < ActiveRecord::Migration[7.0]
  def change
    drop_table :saved_lists
  end
end
