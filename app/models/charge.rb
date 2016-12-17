class Charge < ApplicationRecord
    has_many :transactions, class_name: 'ChargeTransaction'
	belongs_to :user     #, :optional => true 
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
				:brand              => card_type,
				:number             => number,
				:verification_value => cvv,
				:month              => month,
				:year               => year,
				:first_name         => first_name,
				:last_name          => last_name 
				)
		end

		def first_name
           name.split.first 
		end

		def last_name
			return "" if name.split.size <= 1
			name.split.last  
		end

		def cvv
			card_verification_value.strip
		end

		def number
			card_number.strip
		end

		def month
			card_expires_on.month
		end

		def year
			card_expires_on.year
		end


end
