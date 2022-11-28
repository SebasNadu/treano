class KeywordItem < ApplicationRecord
  belongs_to :keyword
  belongs_to :keywordable, polymorphic: true
end
