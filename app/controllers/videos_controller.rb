class VideosController < ApplicationController
  def index
  	@videos = Video.all 
  end

  def new
  end

  def create
  end

end
