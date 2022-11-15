class AddColumnToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :description, :text
    add_column :lists, :public, :boolean, default: true
  end
end
