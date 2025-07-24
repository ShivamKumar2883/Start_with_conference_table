require 'jwt'

module ApiAuthenticable
  ACCESS_SECRET = Rails.application.credentials.jwt_access_secret
  REFRESH_SECRET = Rails.application.credentials.jwt_refresh_secret

  def authenticate_user
    return if action_name == 'create' 

      # Handle different header naming conventions
  access_token = request.headers['HTTP_ACCESS_TOKEN'] || 
                 request.headers['Access-Token'] ||
                 request.headers['access-token']

  # Same for refresh token
  refresh_token = request.headers['HTTP_REFRESH_TOKEN'] || 
                  request.headers['Refresh-Token'] ||
                  request.headers['refresh-token']

    @current_user = verify_access_token(access_token)

    @current_user ||= try_refresh_flow(refresh_token) if refresh_token.present?

    render_unauthorized unless @current_user
  end

  private

  def verify_access_token(token)
    payload = JWT.decode(token, ACCESS_SECRET).first
    JUser.find_by(id: payload['user_id'], active: true)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def try_refresh_flow(token)
    payload = JWT.decode(token, REFRESH_SECRET).first
    user = JUser.find_by(id: payload['user_id'], active: true)
    return unless user && user.refresh_token == token

    generate_new_tokens(user)
    user
  rescue JWT::DecodeError
    nil
  end

  def generate_new_tokens(user)
    new_access = JWT.encode(
      { user_id: user.id, exp: 15.minutes.from_now.to_i },
      ACCESS_SECRET
    )
    new_refresh = JWT.encode(
      { user_id: user.id, exp: 7.days.from_now.to_i },
      REFRESH_SECRET
    )

    user.update!(refresh_token: new_refresh)
    response.headers['New-Access-Token'] = new_access
    response.headers['New-Refresh-Token'] = new_refresh
  end

  def render_unauthorized
    render json: { error: 'Invalid or expired tokens' }, status: :unauthorized
  end

  def current_user
  @current_user
end
end