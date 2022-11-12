class List < ApplicationRecord
  belongs_to :user
  has_many :saved_lists
  has_many :users, through: :saved_lists
  has_many :movie_lists
  has_many :movies, through: :movie_lists
end
