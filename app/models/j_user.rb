class JUser < ApplicationRecord
    has_one :profile, dependent: :destroy
    validates :email, format: { with: /@/, message: "must contain @ symbol"}
    validates :password, length: { minimum: 6 , too_short: "must be at least 6 characters"} 
end
