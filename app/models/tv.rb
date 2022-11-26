class Tv < ApplicationRecord
  acts_as_favoritable
  has_many :list_items, as: :listable
  has_many :lists, through: :list_items
  has_many :media_providers, as: :providable
  has_many :providers, through: :media_providers
  has_many :reviews, as: :reviewable
  has_many :users, through: :reviews
  has_many :genre_items, as: :genreable
  has_many :genres, through: :genre_items
end
