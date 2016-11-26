class Post < ApplicationRecord
	has_ancestry 
	validates_presence_of :content
	belongs_to :photo 


end
