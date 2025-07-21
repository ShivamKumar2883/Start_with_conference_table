class Profile < ApplicationRecord
  belongs_to :j_user

  validates :j_user_id, uniqueness: { on:create }
  validates :name, presence: true
  validates :designation, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true,format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :pincode, presence: true,format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
  validates :profile_pic, presence: true
end