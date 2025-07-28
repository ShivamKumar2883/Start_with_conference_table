class ProfilePicture < ApplicationRecord
  belongs_to :profile, optional: true # This makes the association optional
  validates :image_url, presence: true
end