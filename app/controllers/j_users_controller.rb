class JUsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

    def index
        render json: JUser.all()
    end
    
    def show
        render json: JUser.find(params[:id])
        if user
      render json: user
    else
      render json: { error: "Not found" }, status: 404
    end
    end

  def create
    user = JUser.create(
      email: params[:email],
      password: params[:password],
      createdAt: params[:createdAt],
      updateAt: params[:updateAt]
    )
    if user.save
      render json: user
    else
      render json: { error: "Check the Input formate" }
    end
  end

  def update
    user = JUser.find(params[:id])
    if user
    user.update(
      email: params[:email],
      password: params[:password] ,
      updateAt: params[:updateAt] 
    )
    render json: user
      else
    render json: { error: "User not found" }
  end
  end

    def destroy
    user = JUser.find(params[:id])
    if user
    user.destroy
    render json: JUser.all()
    else 
        render json: {error: "user not found"}
    end
end
end
