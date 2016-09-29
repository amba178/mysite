class StaticPagesController < ApplicationController
  layout :choose_layouts

  def index
  end

  def about
  end

  def contact
  end

  def photos
  end

  private 
  	def choose_layouts
  		if action_name == 'index'
  			'static'
  		else
  			'application'
  		end
  	end

end
