class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_photo, :only => [:show]
  def index
    @photos = Photo.all 
    @uploader = Photo.new.image 
    @uploader.success_action_redirect = new_photo_url 
  end

  def show
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
  		params.require(:photo).permit(:name, :image, :key, :image_processed, :description)
  	end

    def set_photo
      @photo = Photo.find(params[:id])
    end




end
