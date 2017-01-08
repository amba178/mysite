require "rails_helper"

describe PhotosController, :type => :controller do
    login_user 

    it "on create success" do 
        post :create, params: { photo: 
        	{  
        	   name: "salem",
        	   image: "amba",
        	   image_processed: true,
        	   longitue: 34.98, 
        	   latitude:  89.90,
               description: 'best of sagan',
               address: 'Sagan'
        	} }
        	expect(response).to redirect_to(photos_path)
    end
   
end