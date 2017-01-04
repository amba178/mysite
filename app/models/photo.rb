class Photo < ApplicationRecord
	mount_uploader :image, ImageUploader 
	attr_accessor :secure
	has_many :posts 
	geocoded_by :address 
	after_validation :geocode, :if => :address_changed? 

	after_save :enqueue_image, :enqueue_geo_location


	def photo_name
		File.basename(image.path || image.filename ) if image 
	end


	def enqueue_image
    	ImageJob.perform_later(id, key) if key.present?
  	end

  	def enqueue_geo_location
  		GeoLocationJob.perform_later(id)
  	end

end
