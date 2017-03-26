class Video < ApplicationRecord
	has_many :posts, as: :commentable
	
end
