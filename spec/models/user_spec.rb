require "rails_helper"

RSpec.describe User, :type => :model do
 	describe 'Fixtures' do
 		it 'should have a valid factory' do
 			expect(FactoryGirl.create(:user)).to be_valid 
 		end
 	end
end