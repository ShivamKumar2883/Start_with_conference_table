class JUser < ApplicationRecord
    has_one :profile, dependent: :destroy
    before_create :set_api_token


    validates :email, uniqueness: { case_sensitive: false, message: "is already taken" }, format: { with: /@/, message: "must contain @ symbol"}
    validates :password, length: { minimum: 6 , too_short: "must be at least 6 characters"} 


    private
    def set_api_token
        self.api_token = SecureRandom.urlsafe_base64(24)
        set_api_token if JUser.exists?(api_token: api_token)
    end

end
