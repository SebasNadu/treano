class List < ApplicationRecord
  belongs_to :user
  has_many :saved_lists
  has_many :users, through: :saved_lists
  has_many :movies, through: :list_items, source: :movies
  :conditions => "list_items.listable_type = 'Movie'"
  has_many :tvs, through: :list_items, source: :tvs
  :conditions => "list_items.listable_type = 'Tv'"
end
