class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists
  has_many :movie_lists, through: :lists
  has_many :saved_lists
  has_many :lists, through: :saved_lists
  has_many :user_challenges
  has_many :challenges, through: :user_challenges
  has_many :user_streaming_platforms
  has_many :streaming_platforms, through: :user_streaming_platforms
  has_many :movie_reviews
  has_many :movies, through: :movie_reviews
end
