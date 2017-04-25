class VideoUploadsController < ApplicationController
  def new
  	@video_upload = VideoUpload.new
  end

  def create
    byebug
  	@video_upload = VideoUpload.new(title: params[:video_upload][:title],
                                  description: params[:video_upload][:description],
                                  file: params[:video_upload][:file].try(:tempfile).try(:to_path))
  	if @video_upload.save
  		# uploaded_video = @video_upload.upload!(current_user)
    #   uploaded_video = VideoJob.perform_async(@video_upload.id, current_user)
      byebug
  		# if uploaded_video.failed? 
  		# 	flash[:danger] = 'There was an error while uploading your video...'
  		# else
  		#   Video.create({link: "https://www.youtube.com/watch?v=#{uploaded_video.id}"})
  		#   flash[:notice] = 'Your video has been uploaded!'
  		# end
      redirect_to videos_url, notice: 'Your video is being uploading!'

  	else
  		render :new

  	end

  end


  private 
  	def video_upload_params
  		params.require(:vide_upload).permit(:title, :description, :file)
  	end

end
