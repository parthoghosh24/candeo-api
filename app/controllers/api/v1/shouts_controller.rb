class Api::V1::ShoutsController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_action, except: [ :show]
  #POST - /shouts/create - Create Shout
  def create
      shout = Shout.create(params)
      if !shout.blank?
            render json: {:response => "success"}, status: 200
      else
           render json: {:response=>"failed"}, status: 422
      end
  end

  def show
  end

 #GET /shouts/network/:id - Fetch network for user with :id
  def list_network
      network = Shout.fetch_network(params)
      if !network.blank?
        response_map={:network=>network}
        render json: response_map, status: 200
      else
        render json:{:response=>"failed"}, status:422
    end
  end

 #GET /shouts/list/:id - Fetch shouts for user with :id
  def list_shouts
    puts "IN HERE"
     shouts = Shout.fetch_list(params)
     if !shouts.blank?
        response_map={:shouts=>shouts}
        render json: response_map, status: 200
      else
        render json:{:response=>"failed"}, status:422
    end
  end

  private

  def authenticate_with_default_key
       authenticate_or_request_with_http_token do |token, options|
            hash = CandeoHmac.generate_untouched_hmac("candeosecret2015",request.headers['message'])
            puts "gen hash is start#{hash}end"
            puts "incoming hash is start#{token}end"
            return hash == token
       end
       false
  end

  def authenticate_action
     authenticate_or_request_with_http_token do |token, options|
            puts "email is#{request.headers['email']}"
            auth_token = User.find_by(email:request.headers['email']).auth_token
            puts "Message is#{request.headers['message']}"
            hash = CandeoHmac.generate_untouched_hmac(auth_token,request.headers['message'])
            puts "gen hash is start#{hash}end"
            puts "incoming hash is start#{token}end"
            return hash == token
       end
       false
  end

end
