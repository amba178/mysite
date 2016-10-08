class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :after_sign_in_path_for, :after_sign_out_path_for, if: :devise_controller? 
  before_action :prepare_meta_tags, if: 'request.get?'


  def prepare_meta_tags(options={})
  	site_name = "SaganDevelop"
  	title = 'Sagan photo'
  	description = 'Develop sagan area'
  	image = options[:image] 
  	current_url = request.url 

  	defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[web software development mobile app],
      twitter: {
        site_name: site_name,
        site: '@salemA6',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)
    set_meta_tags options

  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :uid, :provider, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :uid, :provider, :image])
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
