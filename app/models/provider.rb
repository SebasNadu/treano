class Provider < ApplicationRecord
  has_many :user_providers
  has_many :users, through: :user_providers
  has_many :media_providers
end
