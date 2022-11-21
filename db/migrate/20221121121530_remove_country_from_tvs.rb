class RemoveCountryFromTvs < ActiveRecord::Migration[7.0]
  def change
    remove_column :tvs, :country, :string
  end
end
