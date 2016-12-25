FactoryGirl.define do
	factory :user do
		first_name Faker::Name.first_name
		last_name  Faker::Name.last_name
		email "#{[*('a'..'z').to_a, *(0..9).to_a].shuffle[0..10].join}@gmail.com" 
		password 'salimali'
		password_confirmation 'salimali'
		confirmed_at Time.now
	end
end