class AddColumnsToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :name, :string
    add_column :providers, :type, :string
    add_column :providers, :logo_url, :string
    add_column :providers, :regions, :text, array: true
    add_column :providers, :watchmode_id, :integer
  end
end
