class RemoveTypeFromMediaProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :media_providers, :type, :string
  end
end
