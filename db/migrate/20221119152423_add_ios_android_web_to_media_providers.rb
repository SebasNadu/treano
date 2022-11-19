class AddIosAndroidWebToMediaProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :media_providers, :ios_url, :string
    add_column :media_providers, :android_url, :string
    add_column :media_providers, :web_url, :string
  end
end
