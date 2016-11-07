class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def index
    @photos = Photo.all 
    # @photos.each do |photo|
    #   if photo.image_processed 
    #     prepare_meta_tags(title: photo.name,
    #                    description: "sagan photo",
    #                    keywords: 'Sagan',
    #                    url: photo.image_url(:thumb),
    #                    image: photo.image_url(:thumb),
    #                    twitter: {card: "summary_large_image"})
    #   end

    # end
    @uploader = Photo.new.image 
    @uploader.success_action_redirect = new_photo_url 
  end

  def show
    @photo = Photo.find(params[:id])
    # prepare_meta_tags(title: @photo.name,
    #                   description: "sagan photo",
    #                   keywords: 'Sagan',
    #                   url: @photo.image_url(:thumb),
    #                   image: @photo.image_url(:thumb),
    #                   twitter: {card: "summary_large_image"})
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




end
