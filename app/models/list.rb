class List < ApplicationRecord
  belongs_to :user
  has_many :saved_lists
end
