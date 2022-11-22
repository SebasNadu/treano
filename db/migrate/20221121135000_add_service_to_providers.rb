class AddServiceToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :service, :string
  end
end
