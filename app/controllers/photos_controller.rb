class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @photos = Photo.all 
  end

  def show
  end

  def new
  	@photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save 
      flash[:notice] = "Successfully created uploaded photo."
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
  		params.require(:photo).permit(:name, :image)
  	end




end
