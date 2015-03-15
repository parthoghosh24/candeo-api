class Api::V1::ResponsesController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_action

  #POST /contents/responses/inspire - Getting inspired from content
  def inspire
    id=ResponseMap.get_inspired(params)
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

#POST /contents/responses/appreciate - Appreciating Content
  def appreciate
    id=ResponseMap.appreciate(params)
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

#POST /contents/responses/skip - Appreciating Content
  def skip
    id=ResponseMap.skip(params)
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
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
