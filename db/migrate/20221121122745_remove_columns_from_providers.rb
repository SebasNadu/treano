class RemoveColumnsFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :provider_name, :string
    remove_column :providers, :logo_path, :string
  end
end
