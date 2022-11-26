class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_one_attached :avatar

  has_many :lists
  has_many :saved_lists
  has_many :lists, through: :saved_lists
  has_many :user_challenges
  has_many :challenges, through: :user_challenges
  has_many :user_providers
  has_many :providers, through: :user_providers
  has_many :reviews

  has_many :movies, through: :reviews, source: :reviewable, source_type: 'Movie'
  has_many :tvs, through: :reviews, source: :reviewable, source_type: 'Tv'

  acts_as_favoritable
  acts_as_favoritor
end
