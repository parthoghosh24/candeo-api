class Api::V1::UsersController < ApplicationController

  before_action :authenticate_action, except: [:register, :login]
  #GET /api/v1/users/:id - Fetch User profile
  def show
    user = User.show(params)
    if user
      response_map={:user => user}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #GET /api/v1/users/:id/appreciations/:timestamp - Fetch User Appreciations
  def get_appreciations
     appreciations = User.get_appreciations(params)
     if appreciations
      response_map={:appreciations => appreciations}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #GET /api/v1/users/:id/inspirations/:timestamp - Fetch User Inspirations
  def get_inspirations
    inspirations = User.get_inspirations(params)
     if inspirations
      response_map={:inspirations => inspirations}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
end

  #GET /api/v1/users/:id/fans/:timestamp - Fetch User fans
  def get_fans
      fans = User.get_fans(params)
     if fans
      response_map={:fans => fans}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #GET /api/v1/users/:id/promoted/:timestamp - Fetch User promoted
  def get_promoted
      promoted = User.get_promoted(params)
     if promoted
      response_map={:promoted => promoted}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #GET /api/v1/users/:id/showcases/:timestamp - Fetch User showcases
  def get_showcases
      showcases = User.get_showcases(params)
     if showcases
      response_map={:showcases => showcases}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end 

  #GET /api/v1/users/posted/1
  def has_posted
     has_posted = User.has_posted?(params)
     response_map = {:response=> has_posted}
     render json: response_map, status: 200 
  end
  #POST /api/v1/users/verify - User verification
  def verify
    user = User.verify(params)
    if user
      response_map={:user => user}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #POST /api/v1/users/login - User logins
  def login
     response = User.login(params)
     if !response.blank?
        user = response[:user]
        url = "http://www.candeoapp.com/verify/#{response[:random_token]}"
        Thread.new do
           CandeoMailer.verify_user(user, url).deliver
        end
        puts "Sending success"
        render json: {:response=>"success"}, status: 200
     else
      render json:{:response=>"failed"}, status:422
      end
  end

  #POST /api/v1/users/register - User registers
  def register
  	id=User.register(params)
  	if !id.blank?
      render json: {:id=>id}, status: 200
  	else
  		render json:{:response=>"failed! Email already taken"}, status:422
  	end
  end

  private 

  def authenticate_action
      authenticate_or_request_with_http_token do |token, options|
          auth_token = User.find_by(email:request.headers['email']).auth_token
          hash = CandeoHmac.generate_untouched_hmac(auth_token, request.headers['message'])
          hash == token
      end
      
  end
end
