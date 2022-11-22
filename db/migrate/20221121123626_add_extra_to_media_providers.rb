class AddExtraToMediaProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :media_providers, :name, :string
    add_column :media_providers, :type, :string
    add_column :media_providers, :region, :string
    add_column :media_providers, :format, :string
    add_column :media_providers, :price, :float
    add_column :media_providers, :seasons, :integer
    add_column :media_providers, :episodes, :integer
  end
end
