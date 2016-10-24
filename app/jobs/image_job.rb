class ImageJob < ApplicationJob
	 # include Sidekiq::Worker
	 queue_as :default

	def perform(id, key)
      photo = Photo.find(id)
      photo.key = key
      photo.remote_image_url = photo.image.direct_fog_url(with_path: true)
      photo.save!
      photo.update_column(:image_processed, true)
    end
  
end
