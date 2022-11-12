class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists
  has_many :saved_lists
  has_many :lists, through: :saved_lists
  has_many :user_challenges
  has_many :challenges, through: :user_challenges
  has_many :user_providers
  has_many :providers, through: :user_providers
  has_many :reviews

  has_many :movies, through: :reviews, source: :movies
  :conditions => "reviews.reviewable_type = 'Movie'"
  has_many :tvs, through: :reviews, source: :tvs
  :conditions => "reviews.reviewable_type = 'Tv'"
end
