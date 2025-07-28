class PostsController < ApplicationController

    before_action :authenticate_user
    # belongs_to :profile
    #this association is done in model to prevent extra data creation as one to many ass..

    #to show all posts as a feed of social media
    def index
        begin 
            posts = Post.all
            render json: posts
        rescue
            render json: {error: "Posts fails to render check the controller."}
        end
    end

    #to show posts as per each user
    def show
        begin
            posts = Profile.find(params[:profile_id]).posts
            render json: posts
        rescue ActiveRecord::RecordNotFound
            render json:{
                error: "Profile not found"
            }
        end
    end

    def create
        ActiveRecord::Base.transaction do
            begin
                profile = Profile.find(params[:profile_id])
                post = profile.posts.build(
                    title: params[:post][:title],
                    content: params[:post][:content],
                    posted_by: profile.j_user.name
                )
                if post.save
                    render json: post
                else
                    render json:{
                        error: "Post validation failed"
                    }                    
                    raise ActiveRecord::Rollback

                end
                rescue => e
                    render json:{
                        error: "Post creation failed"
                    }
                end
            end
        end


    def update
    begin
      post = Profile.find(params[:profile_id]).posts.find(params[:id])
      
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
      post = Profile.find(params[:profile_id]).posts.find(params[:id])
      post.destroy!
      render json: { message: "Post deleted successfully" }
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

end
