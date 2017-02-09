require "rails_helper"

describe PhotosController, :type => :controller do
    login_user 

    it "on create success" do 
        post :create, :format=> 'js',  params: { photo: 
        	{  
        	   name: "salem",
        	   image: "amba"
        	} }
        	expect(response).to render_template(:create)
    end
   
end