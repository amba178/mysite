class Charge < ApplicationRecord
    has_many :transactions, class_name: 'ChargeTransaction'
	belongs_to :user, :optional => true 
	validate :validate_card, on: :create 
	attr_accessor :card_number, :card_verification_value


	def purchase 
		response =GATEWAY.purchase(price_in_cents, credit_card, ip: ip_address)
		transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
		response.success?
	end


	def price_in_cents
		(amount*100).round
	end


	private 

		def validate_card 
			unless credit_card.valid? 
				credit_card.errors.full_messages.each do |message|
					errors.add( :base, message: message )
				end
			end
		end

		def credit_card
			@credit_card ||= ActiveMerchant::Billing::CreditCard.new(
				:brand => card_type,
				:number => card_number,
				:verification_value => card_verification_value,
				:month => card_expires_on.month,
				:year => card_expires_on.year,
				:first_name => first_name,
				:last_name => last_name 
				)
		end

		def first_name
           name.split.first 
		end

		def last_name
			name.split.last 
		end
	


end
