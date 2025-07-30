class JUsersController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:create]
    before_action :authenticate_user, except: [:create, :index]

    def index
      @users = JUser.all()
      # emails = users.map{ |user| user.email }
      # render json: emails
      respond_to :json
    end

    def show
      begin
        @user = JUser.find_by(id: params[:id])
      # render json: user
      respond_to :json
        rescue ActiveRecord::RecordNotFound
      render json: { error: "User with ID #{params[:id]} not found." }
    end
    end

  def create
    ActiveRecord::Base.transaction do
    begin
      @user = UserService.create_user(params[:j_user][:email], params[:j_user][:password])

      @profile = Profile.new(

      j_user: @user,
        name: params[:j_user][:name],
        designation: params[:j_user][:designation],
        address: params[:j_user][:address],
        phone_number: params[:j_user][:phone_number],
        pincode: params[:j_user][:pincode],
        # profile_pic: nil
        profile_pic: params[:j_user][:profile_pic]
      )
      
      if @user.valid? && @profile.valid?
       @user.save!
        @profile.save!

        if params[:j_user][:profile_pic].present?
          @profile.create_profile_picture!(
            image_url: params[:j_user][:profile_pic],
            user_name: params[:j_user][:name]
          )
        end


        @access_token = JWT.encode(
          { user_id: @user.id, exp: 15.minutes.from_now.to_i },
          ApiAuthenticable::ACCESS_SECRET
        )
        @refresh_token = JWT.encode(
          { user_id: @user.id, exp: 7.days.from_now.to_i },
          ApiAuthenticable::REFRESH_SECRET
        )

        response.headers['Access-Token'] = @access_token
        response.headers['Refresh-Token'] = @refresh_token


        # render json: { user: user, profile: profile, profile_pic: profile.profile_picture&.image_url  #profile table ke throught profile_pic table mei jayega fir image_url wale row mei save hoga as optional save!!
        # }, status: :created
        # return

        render 'show'
        # respond_to :json
      else

    raise ActiveRecord::Rollback, "Validation Failed."

    render json: { 
        error: "Validation failed",
        details: e.record.errors.full_messages 
     }
    end #else part end

     rescue ActiveRecord::RecordNotUnique => e
      render json: {
        error: "User already exists",
        details: e.message
     }

     rescue => e
      render json: {
        error: "Registration failed",
        details: e.message
      }

    end
  end
  end

  def update
    begin

      user = UserService.update_user(params[:id], params[:j_user][:email], params[:j_user][:password])
    render json: user
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User with ID #{params[:id]} not found" }
  rescue ActiveRecord::RecordInvalid => e
    render json: { 
      error: "Validation failed",
      details: e.record.errors.full_messages 
    }
  end
end

    def destroy
      begin

        user = JUser.find(params[:id])
        user.destroy!
        render json: { message: "User deleted successfully" }

      rescue ActiveRecord::RecordNotFound
          render json: {error: "User with ID #{params[:id]} not found"}
    end
end
end