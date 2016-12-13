class PostsController < ApplicationController
  respond_to :html, :haml,  :json

  def index
  end

  def new
     @post = Post.new(:parent_id => params[:parent_id])
     # @photo = Photo.find(session[:photo_id])
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    session[:photo_id] ||= @post.photo_id  
    # byebug
    if !session[:photo_id].nil? && session[:photo_id]!= @post.photo_id && !@post.photo_id.nil?
      session[:photo_id] = @photo.photo_id 
    end
    if @post.save
      @photo = Photo.find(session[:photo_id])
      session[:photo_id] = nil 
      # respond_to do |format|
        redirect_to  @photo 
        # format.js 
      # end
    else
     @photo = Photo.find(session[:photo_id])
     @posts = @photo.posts.order("created_at")
     render "photos/show" 
    end
  end

  def update
  end

  #quite not right....
  def destroy
    @post = Post.find(params[:id])
    @photo = Photo.find(session[:photo_id])
    @posts = @photo.posts.order("created_at")
    render "photos/show" 
    @post.destroy
  end

  private
  	def post_params
  		params.require(:post).permit(:content, :photo_id, :parent_id)
  	end
end
