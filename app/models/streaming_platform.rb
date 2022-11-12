class StreamingPlatform < ApplicationRecord
  has_many :user_streaming_platforms
  has_many :users, through: :user_streaming_platforms
  has_many :movie_platforms
  has_many :movies, through: :movie_platforms
end
