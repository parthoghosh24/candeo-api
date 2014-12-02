class Api::V1::UsersController < ApplicationController

  def show
  end

  def login
  end

  def logout
  end

  #POST /users/register - User registers
  def register
  	id=User.register(params)
  	if !id.blank?
  		response_map={:id=> id}
  		render json: response_map, status: 200
  	else
  		render json:{:response=>"failed"}, status:422
  	end
  end
end
