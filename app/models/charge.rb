class Charge < ApplicationRecord
	belongs_to :user 
	validates_presence_of :first_name, :last_name, :state, :city, 
	     :billing_address 
	attr_accessor :card_number, :card_verification_value, 
	            :expiration_day, :expiration_month, :expiration_year
end
