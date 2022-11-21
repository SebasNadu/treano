class RemoveTypeFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :type, :string
  end
end
