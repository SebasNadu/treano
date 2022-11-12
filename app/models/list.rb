class List < ApplicationRecord
  belongs_to :user
  has_many :saved_lists
  has_many :users, through: :saved_lists
  has_many :list_items
  has_many :movies, through: :list_items, source: :listable, source_type: 'Movie'
  has_many :tvs, through: :list_items, source: :listable, source_type: 'Tv'
end
