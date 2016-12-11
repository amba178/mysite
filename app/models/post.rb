class Post < ApplicationRecord
	has_ancestry 
	validates_presence_of :content, :photo_id 
	belongs_to :photo 


end
