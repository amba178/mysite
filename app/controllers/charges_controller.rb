class ChargesController < ApplicationController
	before_filter :authenticate_user! 
  def new
  	@charge = Charge.new 
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  	def param_charge
  		params.require(:charge).permit(:ip_address, :first_name, :last_name,
  			           :card_type, :card_expires_on, :billing_address,
  			           :zip_code, :city, :state, :country)
  	end
end
