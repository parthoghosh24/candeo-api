class Api::V1::RedirectsController < ApplicationController
  #GET /:code - Redirect to long url	
  def show
  	if Redirect.exists?(token:params[:code])
  		redirect_to Redirect.find_by(token:params[:code]).long_url
  	end  	
  end
end
