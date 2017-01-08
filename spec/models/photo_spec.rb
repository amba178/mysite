require "rails_helper"

describe Photo, :type => :model do
 	describe 'Fixtures' do
 		it 'should have a valid factory' do
 			expect(FactoryGirl.create(:photo)).to be_valid 
 		end
 	end
 	
 	describe 'database' do
 		it { should have_db_column(:image) }
 		it { should have_db_column(:address) }
 		it { should have_db_column(:image_processed) }
 		it { should have_db_column(:longitude) }
 		it { should have_db_column(:latitude) }
 		it { should have_db_column(:name) }
 		it { should have_db_column(:description) }
 	end

 	describe 'associations' do
 		it { should have_many(:posts) }
 	end

end