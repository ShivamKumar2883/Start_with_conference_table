class PostsController < ApplicationController

    before_action :authenticate_user, except: [:show, :index]

    #Basic inndex
    # def index
    #     begin 
    #         posts = Post.all
    #         render json: posts
    #     rescue
    #         render json: {error: "Posts fails to render check the controller."}
    #     end
    # end

    #index improvement for RABL
    def index
        @posts = Post.all
        respond_to :json
    end

    #basic show function
    # def show
    #   post = Post.find(params[:id])
    #   render json: post
    # rescue ActiveRecord::RecordNotFound
    #   render json: {error: "Post not found"}
    # end

    #show improvemnets for RABL
    def show 
      @post = Post.find(params[:id])
      respond_to :json
    end

    #sir yah all posts under searched user function in iske help se collection v try kiye h route file mei.
    def feed
        begin
          user = JUser.find(params[:user_id])
          posts = user.posts.order(created_at: :desc)
          # render json: posts
          respond_to :json
        rescue ActiveRecord::RecordNotFound
          render json: { error: "User not found" }
        rescue => e
          render json: { error: "Check eveything and debug agin"}
        end
      end


    def create
        ActiveRecord::Base.transaction do
            begin
        post = current_user.posts.build(
          title: params[:post][:title],
          content: params[:post][:content],
          posted_by: current_user.profile.name
        )
                if post.save
                    render json: post
                else
                    render json:{
                        error: "Post validation failed"
                    }                    
                    raise ActiveRecord::Rollback
                end
    rescue NoMethodError
      render json: { 
        error: "Invalid request format",
        details: "Expected format: { post: { title: '...', content: '...' } }"
      }
    rescue => e
      render json: { 
        error: "Post creation failed",
        details: e.message 
      }
    end
  end
end


    def update
    begin
      post = current_user.posts.find(params[:id])
      
      if post.update(
        title: params[:post][:title],
        content: params[:post][:content]
      )
        render json: post
      else
        render json: { 
          error: "Post update failed",
        }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

  def destroy
    begin
      post = current_user.posts.find(params[:id])
      post.destroy!
      render json: { message: "Post deleted successfully" }
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

end
