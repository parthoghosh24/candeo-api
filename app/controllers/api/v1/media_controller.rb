class Api::V1::MediaController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods

  #POST /api/v1/media/create - Media create
  def create
      if request.headers['email'].blank?
         if authenticate_with_default_key
                  media=Media.upload(params[:media], params[:media_type].to_i)
                  if media
                    render json: {:id=>media.id}, status: 200
                  else
                    render json: {:response => "failed"}, status: 422
                  end
         end
    else
        if authenticate_action
                  media=Media.upload(params[:media], params[:media_type].to_i)
                  if media
                    render json: {:id=>media.id}, status: 200
                  else
                    render json: {:response => "failed"}, status: 422
                  end
         end
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
