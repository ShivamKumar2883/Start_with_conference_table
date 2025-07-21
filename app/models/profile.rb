class Profile < ApplicationRecord
  belongs_to :j_user

  validates :j_user_id, uniqueness: { on: [:create, :update] }
  validates :name, :designation, :address, :profile_pic, presence: true
  validates :phone_number, presence: true,format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :pincode, presence: true,format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
end