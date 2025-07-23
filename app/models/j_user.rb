class JUser < ApplicationRecord
    has_one :profile, dependent: :destroy

    validates :email, uniqueness: { case_sensitive: false, message: "is already taken" }, format: { with: /@/, message: "must contain @ symbol"}
    validates :password, length: { minimum: 6 , too_short: "must be at least 6 characters"} 

end
