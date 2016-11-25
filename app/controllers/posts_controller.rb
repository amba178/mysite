class PostsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  private
  	def post_params
  		params.require(:post).permit(:content)
  	end
end
