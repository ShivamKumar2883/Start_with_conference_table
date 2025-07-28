class Profile < ApplicationRecord
  belongs_to :j_user
  has_one :profile_picture, dependent: :destroy  # Add this line
  has_many :posts, dependent: :destroy

  validates :j_user_id, uniqueness: { on: [:create, :update] }
  validates :name, :designation, :address, presence: true
  validates :phone_number, presence: true,format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :pincode, presence: true,format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
end