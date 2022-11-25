class Genre < ApplicationRecord
  has_many :genre_items
  has_many :movies, through: :genre_items, source: :genreable, source_type: 'Movie'
  has_many :tvs, through: :genre_items, source: :genreable, source_type: 'Tv'
end
