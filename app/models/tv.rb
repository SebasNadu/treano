class Tv < ApplicationRecord
  has_many :lists, as: :listable
  has_many :providers, as: :providable
  has_many :reviews, as: :reviewable
end
