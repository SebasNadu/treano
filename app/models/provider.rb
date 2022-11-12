class Provider < ApplicationRecord
  has_many :user_providers
  has_many :users, through: :user_providers
  has_many :media_providers
  has_many :movies, through: :media_providers, source: :movies
  :conditions => "media_providers.providable_type = 'Movie'"
  has_many :tvs, through: :media_providers, source: :tvs
  :conditions => "media_providers.providable_type = 'Tv'"
end
