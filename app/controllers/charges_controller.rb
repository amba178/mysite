class ChargesController < ApplicationController
	before_filter :authenticate_user! 
  def new
  	@charge = Charge.new 
  end

  def create
    @charge = Charge.new(param_charge)
    @charge.ip_address = request.remote_ip 
    if @charge.save
      if @charge.purchase
        current_user.charges << @charge  if current_user 
        ChargeMailer.charge_confirmation(current_user, ChargeTransaction.last.params).deliver 
        render  'success'
      else
        
        render  'failure'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  	def param_charge
  		params.require(:charge).permit(:ip_address, :card_type, :billing_address,:name,:card_verification_value,
                                     :card_number, :card_expires_on, :billing_address, :zip_code, 
                                      :city, :state, :country, :amount, :user_id)
  	end
end
