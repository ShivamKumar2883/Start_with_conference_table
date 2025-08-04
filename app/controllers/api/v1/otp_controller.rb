# app/controllers/api/v1/otp_controller.rb
module Api
  module V1
    class OtpController < ApplicationController
      skip_before_action :verify_authenticity_token

      def verify
        # Debugging output - check what's being received
        Rails.logger.info "OTP Verification Attempt - Email: #{params[:email]}, Provided OTP: #{params[:otp]}"

        # Get stored OTP and log it
        stored_otp = Rails.cache.read("otp_#{params[:email]}")
        Rails.logger.info "Stored OTP for #{params[:email]}: #{stored_otp.inspect}"

        if stored_otp && params[:otp].to_s == stored_otp.to_s
          Rails.cache.delete("otp_#{params[:email]}")
          render json: { status: "success", message: "OTP verified" }
        else
          render json: { 
            status: "error",
            message: "OTP mismatch",
            debug: {
              received: params[:otp],
              expected: stored_otp,
              email: params[:email]
            }
          }, status: :unauthorized
        end
      end
    end
  end
end