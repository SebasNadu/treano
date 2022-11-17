class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :listable, polymorphic: true, optional: true

  validates :list, :listable_id, :listable_type, presence: true

  validates :list, uniqueness: { scope: [:listable_id, :listable_type], message: "listable_type is already in this list" }
end
