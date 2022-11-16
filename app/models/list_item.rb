class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :listable, polymorphic: true, optional: true
end
