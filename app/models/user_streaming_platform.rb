class UserStreamingPlatform < ApplicationRecord
  belongs_to :user
  belongs_to :streaming_platform
end
