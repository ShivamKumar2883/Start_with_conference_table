module ApiAuthenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, except: [:index]
  end

  def current_user
    @current_user ||= begin
      token = request.headers['Authorization']&.split(' ')&.last
      JUser.find_by(api_token: token) if token
    end
  end

  def authenticate_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end
end