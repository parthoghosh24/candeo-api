class Api::V1::UsersController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_action, except: [:register, :login, :verify, :get_fans, :get_promoted, :get_showcases, :show]

  #GET /api/v1/users/:id - Fetch User profile
  def show
    if request.headers['email'].blank?
         if authenticate_with_default_key
              user = User.show(params)
              if user
                response_map={:user => user}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    else
        if authenticate_action
              user = User.show(params)
              if user
                response_map={:user => user}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
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

      if request.headers['email'].blank?
         if authenticate_with_default_key
               fans = User.get_fans(params)
               if fans
                response_map={:fans => fans}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    else
        if authenticate_action
              fans = User.get_fans(params)
               if fans
                response_map={:fans => fans}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    end

  end

  def get_public_shouts

    if request.headers['email'].blank?
         if authenticate_with_default_key
               shouts = User.get_public_shouts(params)
               if shouts
                response_map={:shouts => shouts}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    else
        if authenticate_action
              shouts = User.get_public_shouts(params)
               if shouts
                response_map={:shouts => shouts}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    end

  end

  #GET /api/v1/users/:id/promoted/:timestamp - Fetch User promoted
  def get_promoted
      if request.headers['email'].blank?
         if authenticate_with_default_key
                 promoted = User.get_promoted(params)
                 if promoted
                  response_map={:promoted => promoted}
                  render json: response_map, status: 200
                else
                  render json:{:response=>"failed"}, status:422
                end
         end
    else
        if authenticate_action
              promoted = User.get_promoted(params)
               if promoted
                response_map={:promoted => promoted}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    end
  end

  #GET /api/v1/users/:id/showcases/:timestamp - Fetch User showcases
  def get_showcases
      if request.headers['email'].blank?
         if authenticate_with_default_key
                 showcases = User.get_showcases(params)
                 if showcases
                  response_map={:showcases => showcases}
                  render json: response_map, status: 200
                else
                  render json:{:response=>"failed"}, status:422
                end
         end
    else
        if authenticate_action
              showcases = User.get_showcases(params)
               if showcases
                response_map={:showcases => showcases}
                render json: response_map, status: 200
              else
                render json:{:response=>"failed"}, status:422
              end
         end
    end

  end

  #GET /api/v1/users/posted/1
  def has_posted
     has_posted = User.has_posted(params)
     response_map = {:response=> has_posted}
     puts "posted hash #{response_map}"
     render json: response_map, status: 200
  end

  #POST /api/v1/users/gcm
  def update_gcm
    response = User.update_gcm(params)
    if response.blank?
      render json:{:response=>"failed"}, status:422
    else
      render json: {:response=>"success"}, status: 200
    end
  end

  #POST /api/v1/users/verify - User verification
  def verify
    if authenticate_with_default_key
          user = User.verify(params)
          if user
            response_map={:user => user}
            render json: response_map, status: 200
          else
            render json:{:response=>"failed"}, status:422
          end
    end
  end

  #POST /api/v1/users/login - User logins
  def login
     if authenticate_with_default_key
        response = User.login(params)
         if !response.blank?
            user = response[:user]
            url = "http://www.candeoapp.com/verify/#{response[:random_token]}"
            Thread.new do
               CandeoMailer.verify_user(user, url).deliver
               ActiveRecord::Base.connection.close
            end
            puts "Sending success"
            render json: {:response=>"success"}, status: 200
         else
          render json:{:response=>"failed"}, status:422
        end
     end
  end

  #POST /api/v1/users/register - User registers
  def register
      if authenticate_with_default_key
            id=User.register(params)
            if !id.blank?
              render json: {:id=>id}, status: 200
            else
              render json:{:response=>"failed! Email already taken"}, status:422
            end
      end
  end

  def update_profile
     response = User.update_profile(params)
     if !response.blank?
          render json: {:response=> response}, status:200
     else
          render json: {:response=> "failed"}, status:422
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
