class List < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :saved_lists
  has_many :users, through: :saved_lists
  has_many :list_items, dependent: :destroy
  has_many :movies, through: :list_items, source: :listable, source_type: 'Movie'
  has_many :tvs, through: :list_items, source: :listable, source_type: 'Tv'

  validates :list_name, presence: true
  has_one_attached :cover_picture
end
