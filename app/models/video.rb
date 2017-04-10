class Video < ApplicationRecord

	has_many :posts, as: :commentable
	YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
	validates :link, presence: true, format: YT_LINK_FORMAT
	before_save :create_video 


 

	def create_video

		video = Yt::Video.new url: self.link
		self.uid = video.id
		self.title = video.title
		self.author = video.auth.nil? ? 'Youtube' : video.auth 
		self.likes = video.like_count
		self.dislikes = video.dislike_count
		self.published_at = video.published_at 
		self.duration = parse_duration(video.duration)
		rescue Yt::Errors::NoItems 
			self.title = ''
	end

	def parse_duration(d)
		hr = (d/3600).floor
		min = ((d - (hr*3600)) / 60).floor
		sec = (d - (hr*3600) - (min*60)).floor
		hr =  '0' + hr.to_s if hr.to_i < 10 
		min = '0' + min.to_s if min.to_i < 10 
		sec = '0' + sec.to_s if sec.to_i < 10 
		hr.to_s + ':' + min.to_s + ':' + sec.to_s 
	end
	
end
