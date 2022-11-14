class AddIosAppstoreUrlAndAndroidPlaystoreUrlToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :ios_appstore_url, :string
    add_column :providers, :android_playstore_url, :string
  end
end
