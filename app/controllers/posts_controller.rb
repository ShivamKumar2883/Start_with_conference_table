class PostsController < ApplicationController

    before_action :authenticate_user, except: [:show_by_id, :show, :index]
    # belongs_to :user, class_name: 'JUser', foreign_key: 'user_id'
    #this association is done in model to prevent extra data creation as one to many ass..

    #to show all posts as a feed of social media.
    def index
        begin 
            posts = Post.all
            render json: posts
        rescue
            render json: {error: "Posts fails to render check the controller."}
        end
    end

    # to show by post id in case someone share the post to you and you can see the direct post, 
    # no access token or user check its like media share and 
    # GET http://localhost:3000/posts/1 and 
    # GET http://localhost:3000/j_users/5/profiles/5/posts/1
    def show_by_id
      post = Post.find(params[:id])
      render json: post
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Post not found"}
    end

    # to show posts as per users profile feed ...if you click on someone's profile 
    # it should show all posts related to that person what he posted.
     # GET http://localhost:3000/j_users/1/profiles/1/posts
    # http://localhost:3000/j_users/5/profiles/5/posts/
    def show
      user = JUser.find(params[:profile_id]) 
      posts = user.posts.order(created_at: :desc)
      render json: posts
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Profile not found"}
    end

    def create
        ActiveRecord::Base.transaction do
            begin
                user = JUser.find(params[:profile_id]) 
        post = user.posts.build(
          title: params[:post][:title],
          content: params[:post][:content],
          posted_by: user.profile.name #user name profile table se aa raha h!!
        )
                if post.save
                    render json: post
                else
                    render json:{
                        error: "Post validation failed"
                    }                    
                    raise ActiveRecord::Rollback

                end
                rescue ActiveRecord::RecordNotFound
      render json: { error: "Profile not found" }
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
      user = JUser.find(params[:j_user_id])
      post = user.posts.find(params[:id])
      
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
      user = JUser.find(params[:j_user_id])
      post = user.posts.find(params[:id])
      post.destroy!
      render json: { message: "Post deleted successfully" }
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

end
