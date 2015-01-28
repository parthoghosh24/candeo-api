class Api::V1::MediaController < ApplicationController

  #POST /api/v1/media/create - Media create	
  def create
  	media=Media.upload(params[:media], params[:media_type].to_i)
  	if media
  		render json: {:id=>media.id}, status: 200
  	else
  		render json: {:response => "failed"}, status: 422
  	end  	
  end
end
