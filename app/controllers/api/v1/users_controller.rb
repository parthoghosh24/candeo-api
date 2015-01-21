class Api::V1::UsersController < ApplicationController

  def show
  end

  #POST /users/verify - User verification
  def verify
    hmac = User.verify(params)
    if !hmac.blank?
      response_map={:hmac => hmac}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #POST /users/login - User logins
  def login
     response = User.login(params)
     if !response.blank?
        user = response[:user]
        url = "http://www.candeoapp.com/#{response[:random_token]}"  
        Thread.new do
           CandeoMailer.verify_user(user, url).deliver        
        end        
        render json: "success", status: 200
     else
      render json:{:response=>"failed"}, status:422
      end     
  end

  #POST /users/register - User registers
  def register
  	id=User.register(params)
  	if !id.blank?  		
      render json: {:id=>id}, status: 200      
  	else
  		render json:{:response=>"failed"}, status:422
  	end
  end
end
