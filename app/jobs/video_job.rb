class ImageJob < ApplicationJob
	 # include Sidekiq::Worker
	 
	 queue_as :default

	def perform(id, key)
   
    end
  
end
