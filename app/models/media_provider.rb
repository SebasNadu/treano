class MediaProvider < ApplicationRecord
  belongs_to :provider
  belongs_to :providable, polymorphic: true
end
