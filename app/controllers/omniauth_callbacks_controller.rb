class OmniauthCallbacksController < Devise::OmniauthCallbacksController 
	def all
		 @user = User.from_omniauth(request.env["omniauth.auth"])
        # raise request.env["omniauth.auth"].to_yaml 


        # byebug
    	if @user.persisted? 
    		flash.notice = 'Signed in' if @user.confirmed_at 
     	 	sign_in_and_redirect @user  #, :event => :authentication #this will throw if @user is not activated
     	 	# set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    	else
     	 	session["devise.user_attributes"] =  @user.attributes
      		redirect_to new_user_registration_url
    	end
	end


	# def failure
	# 	redirect_to root_path 
	# end

	alias_method :twitter, :all
    alias_method :facebook, :all  


end
