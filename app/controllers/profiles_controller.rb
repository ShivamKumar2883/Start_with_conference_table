class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def show
    begin
      profile = ProfileService.get_profile(params[:j_user_id])
      render json: profile
    rescue ActiveRecord::RecordNotFound 
      render json: { error: "Profile not found with ID #{params[:j_user_id]} for user" },  status: :not_found
    end
  end

  # def create
  #   begin
  #     profile = ProfileService.create_profile(params[:j_user_id], params[:profile])
  #     render json: profile
  #   rescue ActionController::ParameterMissing
  #     render json: { error: "Missing profile parameters" }
  #   rescue ActiveRecord::RecordInvalid => e
  #     render json: { error: "Profile creation failed", details: e.record.errors.full_messages }
  #   rescue ActiveRecord::RecordNotUnique
  #     render json: { error: "User already has a profile" }
  #   end
  # end

  def update
    begin
      profile = ProfileService.update_profile(params[:j_user_id], params[:profile])
      render json: profile
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Profile not found with ID #{params[:j_user_id]} for user" }
    rescue ActionController::ParameterMissing
      render json: { error: "Missing profile parameters" }
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Profile update failed", details: e.record.errors.full_messages }
    end
  end
end