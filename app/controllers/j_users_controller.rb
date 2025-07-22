class JUsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

    def index
      users = JUser.all()
      emails = users.map{ |user| user.email }
      render json: emails
    end

    def show
      begin
        user = JUser.find_by(id: params[:id])
      render json: user
        rescue ActiveRecord::RecordNotFound
      render json: { error: "User with ID #{params[:id]} not found." }
    end
    end

  def create
    ActiveRecord::Base.transaction do
    begin
      user = UserService.create_user(params[:j_user][:email], params[:j_user][:password])

      profile = Profile.new(

      j_user: user,
        name: params[:j_user][:name],
        designation: params[:j_user][:designation],
        address: params[:j_user][:address],
        phone_number: params[:j_user][:phone_number],
        pincode: params[:j_user][:pincode],
        profile_pic: params[:j_user][:profile_pic]
      )

      user_valid = user.valid?
      profile_valid = profile.valid?
      
      if user_valid && profile_valid 
       user.save!
        profile.save!

        render json: { user: user, profile: profile }, status: :created
        return
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