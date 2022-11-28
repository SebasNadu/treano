class Keyword < ApplicationRecord
  has_many :keyword_items
  has_many :movies, through: :keyword_items, source: :keywordable, source_type: 'Movie'
  has_many :tvs, through: :keyword_items, source: :keywordable, source_type: 'Tv'
end
