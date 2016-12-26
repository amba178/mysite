require "rails_helper"

RSpec.describe User, :type => :model do
 	describe 'Fixtures' do
 		it 'should have a valid factory' do
 			expect(FactoryGirl.create(:user)).to be_valid 
 		end
 	end
 	
 	describe 'database' do
 		it { should have_db_column(:first_name) }
 		it { should have_db_column(:last_name) }
 		it { should have_db_column(:image) }
 		it { should have_db_column(:email) }
 		it { should have_db_column(:nickname) }
 		it { should have_db_column(:auth_token) }
 		it { should have_db_column(:provider) }
 		it { should have_db_column(:uid) }
 		it { should have_db_index(:email) }
 		it { should_not  validate_uniqueness_of(:email)} 
 	end

 	describe 'valid email' do
 		it { should allow_value('salemamba@gmail.com').for(:email)}
 		it { should allow_value('alikadir123@yahoo.net').for(:email)}
 	end

 	describe 'invalid email' do
 		it { should_not allow_value('salemamba@gmail').for(:email)}
 		it { should_not allow_value('alikadir123yahoo.net').for(:email)}
 	end

 	describe 'associations' do
 		it { should have_many(:charges) }
 	end

end