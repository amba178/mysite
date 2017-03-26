class Post < ApplicationRecord
	has_ancestry 
	validates_presence_of :content, :photo_id 
	# belongs_to :imageable, polymorphic: true 
	belongs_to :photo 
	belongs_to :videos 

end
