class RegistrationsController < Devise::RegistrationsController 

	def show
		@user = current_user 
	end



    protected 

  		def update_resource(resource, params)
  			if params[:password].blank? && params[:password_confirmation].blank?
  				params.delete(:password)
  				params.delete(:password_confirmation)
    			resource.update_without_password(params)
    		else
    			resource.update_attributes(params)
    		end
 		end

		def after_sign_up_path_for(resource)
		     photos_path
		end

		def after_update_path_for(resource)
			user_path 
		end

		def after_inactive_sign_up_path_for(resource)
			photos_path
		end
end
