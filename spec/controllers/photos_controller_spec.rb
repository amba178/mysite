require "rails_helper"

describe PhotosController, :type => :controller do
    login_user 

    it "on create success" do 
        post :create, params: { photo: 
        	{  
        	   name: "salem",
        	   image: "amba"
        	} }
        	expect(response).to redirect_to(photos_path)
    end
   
end