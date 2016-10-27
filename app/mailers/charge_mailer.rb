class ChargeMailer < ApplicationMailer

  def charge_confirmation(current_user, params)
    @params = params
    @user = current_user
    @date = params['timestamp'].to_datetime
    mail from: 'no-reply@developsagan.com', to: current_user.email , cc: 'salemamba@gmail.com', subject: 'Develop Sagan Donation'
  end
end
