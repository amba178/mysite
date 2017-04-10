class VideosController < ApplicationController

  def index
  	@videos = Video.order(created_at:  :desc)
  end
  
  def show
  	video = Video.find(params[:id])
  	# if !current_user.nil? && current_user.provider=="google_oauth2"
  	# 	account = video.yt_account(current_user)
  	# 	@video = video.yt_video(account)
  	# else
  		@video = Video.find(params[:id])
  	# end
  end

  
  def new
  	@video = Video.new
  end

  def create
  	@video = Video.new(video_params)
    if @video.save
    	flash[:notice] = 'Video added!'
    	redirect_to videos_path
    else
    	render :new
    end

  end


  private 

  	def video_params
  		params.require(:video).permit(:link)
  	end

end
