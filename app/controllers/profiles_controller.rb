class ProfilesController < ApplicationController
  before_action :authenticate_user

  def show
    begin
      
      @profile = ProfileService.get_profile(params[:j_user_id])
      respond_to :json
      # render json: profile.as_json.merge(
      #   profile_pic: profile.profile_picture&.image_url
      # )
    rescue ActiveRecord::RecordNotFound 
      render json: { error: "Profile not found with ID #{params[:j_user_id]} for user" },  status: :not_found
    end
  end

  def update
  begin
    @profile = ProfileService.update_profile(params[:j_user_id], params[:profile].permit(
      :name, :designation, :address, :phone_number, :pincode
    ))

    if params[:profile][:profile_pic].present?
      if @profile.profile_picture
        @profile.profile_picture.update!(image_url: params[:profile][:profile_pic])
      else
        @profile.create_profile_picture!(
          image_url: params[:profile][:profile_pic],
          user_name: @profile.name
        )
      end

      if @profile.has_attribute?(:profile_pic)
        @profile.update_column(:profile_pic, params[:profile][:profile_pic])
      end
    end

    respond_to :json

#     render json: profile.as_json.except("profile_pic").merge(
#   profile_pic: profile.profile_picture&.image_url
# )


  rescue ActiveRecord::RecordNotFound
    render json: { error: "Profile not found" }, status: :not_found
  rescue ActionController::ParameterMissing
    render json: { error: "Missing parameters" }, status: :bad_request
  rescue ActiveRecord::RecordInvalid => e
    render json: { 
      error: "Profile update failed", 
      details: e.record.errors.full_messages 
    }, status: :unprocessable_entity
  end
end

end