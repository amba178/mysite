class VideoUpload < ActiveType::Object 
	attribute :file, :varchar 
	attribute :description, :text
	attribute :title, :varchar 


	validates :file, presence: true
	validates :title, presence: true 
	# after_save :enqueue_video



	def upload!(user)
		account = Yt::Account.new refresh_token: ENV['REFRESH_TOKEN']
		account.upload_video self.file, title: self.title, description: self.description, privacy_status: 'public'
	end


	def enqueue_video
		VideoUploadJob.perform_async(id)
	end




end