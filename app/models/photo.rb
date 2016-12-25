class Photo < ApplicationRecord
	mount_uploader :image, ImageUploader 
	attr_accessor :secure
	has_many :posts 

	after_save :enqueue_image

	def photo_name
		File.basename(image.path || image.filename ) if image 
	end


	def enqueue_image
    	ImageJob.perform_later(id, key) if key.present?
  	end

end
