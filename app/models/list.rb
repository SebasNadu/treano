class List < ApplicationRecord
  belongs_to :user
  has_many :saved_lists
  has_many :users, through: :saved_lists
  has_many :movies, as: :listable
  has_many :tvs, as: :listable
end
