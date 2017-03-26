class Photo < ApplicationRecord
	# mount_uploader :image, ImageUploader 
	attr_accessor :secure
	has_many :posts, as: :commentable
	belongs_to :location 
	# geocoded_by :address 
	# after_validation :geocode, :if => :address_changed? 
	before_create :default_name 
	before_create  :location

	# after_save :enqueue_image, :enqueue_geo_location


	def default_name
		# self.name ||= File.basename(image, '.*').titleize if image
		self.name ||= "Best of Sagan/Burji"
	end

	def location
		self.location = Location.last
	end


	def enqueue_image
    	ImageJob.perform_later(id, key) if key.present?
  	end

  	def enqueue_geo_location
  		GeoLocationJob.perform_later(id)
  	end

end
