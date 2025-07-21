class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def show
    begin
      profile = ProfileService.get_profile(params[:j_user_id])
      render json: profile
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Profile not found for user" }, status: :not_found
    end
  end

  def create
    begin
      profile = ProfileService.create_profile(params[:j_user_id], params[:profile])
      render json: profile, status: :created
    rescue ActionController::ParameterMissing
      render json: { error: "Missing profile parameters" }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Profile creation failed", details: e.record.errors.full_messages }, 
             status: :unprocessable_entity
    rescue ActiveRecord::RecordNotUnique
      render json: { error: "User already has a profile" }, status: :conflict
    end
  end

  def update
    begin
      profile = ProfileService.update_profile(params[:j_user_id], params[:profile])
      render json: profile
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Profile not found" }, status: :not_found
    rescue ActionController::ParameterMissing
      render json: { error: "Missing profile parameters" }, status: :bad_request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Profile update failed", details: e.record.errors.full_messages }, 
             status: :unprocessable_entity
    end
  end
end