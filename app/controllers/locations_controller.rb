class LocationsController < ApplicationController
	before_action :authenticate_user!
   # before_action :set_photo, :only => [:show]

  def new
  	@location = Location.new
  end

  def edit
  end

  def create
  	@location = Location.new(location_params)
  	session[:last_back] = request.env['HTTP_REFERER']
  	if @location.save
  		flash.notice = "You can upload your photos now, choose file form below."
  		redirect_to photos_url
  	end
  end

  def update
  end

  private
  	def location_params
  		params.require(:location).permit(:address, :longitude, :latitude, :description)
  	end
end
