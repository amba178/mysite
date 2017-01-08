require "rails_helper"

describe RegistrationsController, :type => :controller do

    it "on create success" do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, params: { user: 
        	{  
        	   first_name: "salem",
        	   last_name: "amba",
        	   email: "user@example.or",
        	   password: "password", 
        	   password_confirmation: "password" 
        	} }
        	expect(response).to redirect_to(photos_path)
    end
   
   describe  do
      	login_user  

    	it "on update success" do 
       		 put :update, params: { user: 
        		{  
        	  	 first_name: "salem",
        	  	 last_name: "amba",
        	  	 email: "user@example.or",
        	  	 password: "password", 
        	  	 password_confirmation: "password" 
        		} }
        		expect(response).to redirect_to(user_path)
    	end

	end 
 	
 	
end