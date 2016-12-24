class PhotosController < ApplicationController
  before_action :authenticate, if: -> {Rails.env.production?} 
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :set_photo, :only => [:show]

  def index
    @photos = Photo.all 
    @uploader = Photo.new.image 
    @uploader.success_action_redirect = new_photo_url 
  end

  def show
    @posts = @photo.posts.order("created_at")
    session[:photo_id]=@photo.id 
    @post = Post.new(:parent_id => params[:parent_id])
  end

  def new
  	@photo = Photo.new(key: params[:key])
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save 
      flash.now.notice = "Successfully created uploaded photo."
      redirect_to photos_url 
    else
      render 'new'
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
  		params.require(:photo).permit(:name, :image, :key, :image_processed, :description, :parent_id)
  	end

    def set_photo
      @photo = Photo.find(params[:id]) if !params[:id].nil?

      @photo = Photo.find(params[:post][:photo_id]) if !params[:post].nil?
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['PHOTOS_USERNAME'] && password == ENV['PHOTOS_PASSWORD']
      end
    end


end
