class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true, optional: true

  validates :rating, presence: true, numericality: { only_integer: true, in: 1..10 }
  validates :content, presence: true, length: { in: 6..255 }
  # validates :user, uniqueness: { scope: [:reviewable_id, :reviewable_type], message: "You already reviewed this" }
end
