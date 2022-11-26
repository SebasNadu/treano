class GenreItem < ApplicationRecord
  belongs_to :genre
  belongs_to :genreable, polymorphic: true, optional: true
end
