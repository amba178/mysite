class Location < ApplicationRecord
	has_many :photos, dependent: :destroy
	geocoded_by :address 
	after_validation :geocode, :if => :address_changed? 
end
