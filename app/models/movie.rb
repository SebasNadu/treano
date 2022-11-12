class Movie < ApplicationRecord
  has_many  :movie_reviews
  has_many :users, through: :movie_reviews
  has_many :movie_lists
  has_many :lists, through: :movie_lists
  has_many :movie_platforms
  has_many :streaming_platforms, through: :movie_platforms
  has_many :movie_genres
  has_many :genres, through: :movie_genres
end
