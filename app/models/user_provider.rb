class UserProvider < ApplicationRecord
  belongs_to :user
  belongs_to :provider
end
