class VideoUploadJob < ApplicationJob
	
	 queue_as :default

	def perform(video_id)
		video_upload = VideoUpload.find(video_id)
		uploaded_video = video_upload.upload!(current_user)
		if uploaded_video.processed? 
			video=Video.create({link: "https://www.youtube.com/watch?v=#{uploaded_video.id}"})
			video.update_column(:video_processed => true)
		else
			"salem"
		end
   
    end
  
end
