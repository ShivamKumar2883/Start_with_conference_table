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
        rescue Active::RecordNotFound
      render json: { error: "User with ID #{params[:id]} not found." }
    end
    end

  def create
    begin
      user = UserService.create_user(params[:j_user][:email], params[:j_user][:password])
      render json: user
    rescue ActiveRecord::RecordInvalid => e
      render json: { 
        error: "Validation failed",
        details: e.record.errors.full_messages 
    }
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