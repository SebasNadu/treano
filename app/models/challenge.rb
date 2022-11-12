class Challenge < ApplicationRecord
  has_many :user_challenges
  has_many :users, through: :user_challenges
end
