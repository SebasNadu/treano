class Provider < ApplicationRecord
  has_many :user_providers
  has_many :users, through: :user_providers
  has_many :media_providers
  has_many :movies, through: :media_providers, source: :providable, source_type: 'Movie'
  has_many :tvs, through: :media_providers, source: :providable, source_type: 'Tv'
end
