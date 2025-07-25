require 'jwt'
require 'securerandom'

module ApiAuthenticable
  ACCESS_SECRET = ENV['JWT_ACCESS_SECRET'] || SecureRandom.hex(32)
  REFRESH_SECRET = ENV['JWT_REFRESH_SECRET'] || SecureRandom.hex(32)

  def authenticate_user

    access_token = request.headers['HTTP_ACCESS_TOKEN'] || 
                  request.headers['Access-Token'] || 
                  request.headers['access-token']

    refresh_token = request.headers['HTTP_REFRESH_TOKEN'] || 
                   request.headers['Refresh-Token'] || 
                   request.headers['refresh-token']

    if access_token.to_s.strip.empty? && refresh_token.to_s.strip.empty?
      return render_authentication_error(
        code: 'missing_tokens',
        message: 'No authentication tokens provided',
        status: 401
      )
    end

    if access_token.present?
      begin
        decoded_payload = JWT.decode(access_token, ACCESS_SECRET, true, { algorithm: 'HS256' }).first
        @current_user = JUser.find_by(id: decoded_payload['user_id'])
        
        unless @current_user
          return render_authentication_error(
            code: 'user_not_found',
            message: 'User associated with token not found',
            status: 404
          )
        end

        return true
      rescue JWT::ExpiredSignature

      rescue JWT::DecodeError, JWT::VerificationError
        return render_authentication_error(
          code: 'invalid_access_token',
          message: 'Invalid access token',
          status: 401
        )
      end
    end

    if refresh_token.present?
      begin
        decoded_payload = JWT.decode(refresh_token, REFRESH_SECRET, true, { algorithm: 'HS256' }).first
        user = JUser.find_by(id: decoded_payload['user_id'])
        
        unless user
          return render_authentication_error(
            code: 'user_not_found',
            message: 'User associated with token not found',
            status: 404
          )
        end

        unless user.refresh_token == refresh_token
          return render_authentication_error(
            code: 'token_mismatch',
            message: 'Refresh token does not match stored token',
            status: 401
          )
        end

        new_access_token = generate_token(user.id, ACCESS_SECRET, 15.minutes)
        new_refresh_token = generate_token(user.id, REFRESH_SECRET, 7.days)

        user.update!(refresh_token: new_refresh_token)
        response.headers['New-Access-Token'] = new_access_token
        response.headers['New-Refresh-Token'] = new_refresh_token

        @current_user = user
        return true
      rescue JWT::ExpiredSignature
        return render_authentication_error(
          code: 'expired_refresh_token',
          message: 'Refresh token has expired',
          status: 401
        )
      rescue JWT::DecodeError, JWT::VerificationError
        return render_authentication_error(
          code: 'invalid_refresh_token',
          message: 'Invalid refresh token',
          status: 401
        )
      end
    end

    render_authentication_error(
      code: 'unauthorized',
      message: 'Authentication failed',
      status: 401
    )
  end

  private

  def generate_token(user_id, secret, expires_in)
    payload = {
      user_id: user_id,
      exp: Time.now.to_i + expires_in.to_i
    }
    JWT.encode(payload, secret, 'HS256')
  end

  def render_authentication_error(code:, message:, status:)
    render json: {
      error: {
        code: code,
        message: message,
        timestamp: Time.now.iso8601
      }
    }, status: status
  end
end