class PostsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save

    else
     @photo = Photo.find(params[:post][:photo_id])
     render "photos/show" 
    end
  end

  def update
  end

  private
  	def post_params
  		params.require(:post).permit(:content, :photo_id)
  	end
end
