class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :after_sign_in_path_for, :after_sign_out_path_for, if: :devise_controller? 
  # before_action :prepare_meta_tags, if: 'request.get?'
  

  helper_method   :full_title


  def full_title(page_title='')
    base_title = "Develop Sagan"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end


  protected

  # def local_request?
  #   false
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uid, :provider, :image, :auth_token])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uid, :provider, :image, :auth_token])
  end

  def after_sign_out_path_for(resource_or_scope)
  	photos_path 
  end

  def after_sign_in_path_for(resource)
  	stored_location_for(resource) ||  request.referer || root_path 
  	
  	if resource.is_a?(User) 
      photos_path 
  	else
  		super 
  	end
  end


end
