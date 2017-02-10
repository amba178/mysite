Twilio.configure do |config| 
	config.account_sid = ENV['twilio_account_sd']
	config.auth_token = ENV['twilio_auth_token']
end