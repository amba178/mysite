class PhotosController < ApplicationController
  
  # before_action :authenticate, if: -> {Rails.env.production? && curren_user.==''} 
  respond_to :html, :haml,  :json
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_photo, :only => [:show]

  def index
    @photos = Photo.all 
    # @uploader = Photo.new.image 
    # @uploader.success_action_redirect = new_photo_url 
  end

  def show
    @posts = @photo.posts.order("created_at")
    session[:commentable_id]=@photo.id 
    @post = Post.new(:parent_id => params[:parent_id])
  end

  def new
  	@photo = Photo.new()
  end

  def create
    @photo = Photo.create(photo_params)
    respond_to do |format|
      format.js {}
    end   
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
  	def photo_params
  		params.require(:photo).permit(:name, :image_video_url, :key, :description, 
                                    :commentable_id, :longitude, :latitude, :address, :location_id)
  	end

    def set_photo
      @photo = Photo.find(params[:id]) if !params[:id].nil?

      @photo = Photo.find(params[:post][:commentable_id]) if !params[:post].nil?
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['PHOTOS_USERNAME'] && password == ENV['PHOTOS_PASSWORD']
      end
    end


end
