FactoryGirl.define do
	sequence :email do |n|
		Faker::Internet.free_email.downcase  
	end
	factory :user do
		first_name Faker::Name.first_name
		last_name  Faker::Name.last_name
		email
		password 'salimali'
		password_confirmation 'salimali'
		confirmed_at Time.now
	end
end