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

    if !session[:photo_id].nil? && session[:photo_id]!= @post.photo_id && !@post.photo_id.nil?
      session[:photo_id] = @photo.photo_id 
    end

    respond_to do |format|
      if @post.save
        @photo = Photo.find(session[:photo_id])
        session[:photo_id] = nil 
        format.html {redirect_to  @photo}
        format.js {}
        # format.json { render json: @post, status: :created, location: @photo}  
      else
        @photo = Photo.find(session[:photo_id])
        @posts = @photo.posts.order("created_at")
        format.js {} 
        format.html { render 'photos/show'}
       
      end
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
