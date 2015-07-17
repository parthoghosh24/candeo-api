class Api::V1::ContentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include ActionView::Helpers::DateHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate_action, except: [:show_web, :web_top_performances, :test, :show, :get_performances_map, :list_performances, :limelight, :list_limelight]

  #GET /api/v1/contents/test - API test
  def test

     if Rails.env.staging?
        render json:{response:"Welcome to Candeo TEST...Rise and shine!"}
     else
        render json:{response:"Welcome to Candeo...Rise and shine!"}
     end

  end

  #GET /api/v1/contents/performances/show - Fetch Last Week Performances
  def get_performances_map
    if request.headers['email'].blank?
         if authenticate_with_default_key
              performanceMap = Performance.fetch_performance
              if performanceMap.blank?
                  render json:{:response=>"failed"}, status:422
              else
                  render json: {:performance => performanceMap}, status: 200
              end
         end
    else
        if authenticate_action
              performanceMap = Performance.fetch_performance
              if performanceMap.blank?
                  render json:{:response=>"failed"}, status:422
              else
                  render json: {:performance => performanceMap}, status: 200
              end
         end
    end
  end

  #GET /api/v1/contents/performances/list/:rank - Fetch 10 showcases sorted by rank in ascending order
  def list_performances

      if request.headers['email'].blank?
         if authenticate_with_default_key
              performances = Performance.performance_list(params)
              if performances.blank?
                  render json:{:response=>"failed"}, status:422
              else
                  render json: {:performances => performances}, status: 200
              end
         end
    else
        if authenticate_action
              performances = Performance.performance_list(params)
              if performances.blank?
                  render json:{:response=>"failed"}, status:422
              else
                  render json: {:performances => performances}, status: 200
              end
         end
    end

  end

  #GET /api/v1/contents/limelight/:id - Fetch Showcase from queue which has not been responded by user yet
  def limelight
      if request.headers['email'].blank?
         if authenticate_with_default_key
              limelightMap = ShowcaseQueue.fetch(params)
              if limelightMap.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: {:limelight=>limelightMap}, status: 200
              end
         end
    else
        if authenticate_action
              limelightMap = ShowcaseQueue.fetch(params)
              if limelightMap.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: {:limelight=>limelightMap}, status: 200
              end
         end
    end



  end

 #GET /api/v1/contents/limelights/list/:user_id - Fetch Showcase queue list for user
  def list_limelight
      if request.headers['email'].blank?
         if authenticate_with_default_key
              list = ShowcaseQueue.list_limelights(params)
              if list.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: {:limelights=>list}, status: 200
              end
         end
    else
        if authenticate_action
              list = ShowcaseQueue.list_limelights(params)
              if list.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: {:limelights=>list}, status: 200
              end
         end
    end



  end

#GET /api/v1/web/contents/:id/:type - Show Content Detail Screen
 def show_web
  contentMap=Content.show(params)
  if contentMap.blank?
     render json:{:response=>"failed"}, status:422
  else
    if params[:callback].blank?
        render json: contentMap, status: 200
    else
      render json: contentMap,callback: params[:callback], status: 200
    end

  end
 end

 #GET /api/v1/web/performances - Show Content Detail Screen
 def web_top_performances
      performances = Content.web_top_performances
      if performances.blank?
        render json:{:response=>"failed"}, status:422
      else
        response_map={:performances => performances}
        if params[:callback].blank?
            render json: response_map, status: 200
        else
          render json: response_map,callback: params[:callback], status: 200
        end
     end
 end



  #GET /api/v1/contents/:id/:type - Show Content Detail Screen
  def show
    if request.headers['email'].blank?
         if authenticate_with_default_key
              contentMap=Content.show(params)
              if contentMap.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: contentMap, status: 200
              end
         end
    else
        if authenticate_action
              contentMap=Content.show(params)
              if contentMap.blank?
                 render json:{:response=>"failed"}, status:422
              else
                 render json: contentMap, status: 200
              end
         end
    end



  end

  #POST  /api/v1/contents/create - Create Content
  def create
    puts params
    case params[:type].to_i
    when 1 #showcase
       id=Showcase.create_showcase(params)
    when 2 #status
       id=Status.create_status(params)
    end

    if !id.blank?
      response_map={:id=> id}
      puts response_map.to_json
      Thread.new do
          showcase = Showcase.find(id)
          if showcase
             ids = User.where("gcm_id is not null and id<>?",params[:user_id]).pluck(:gcm_id)
             if ids.size > 0
                type="Written"
                 if showcase.content.content_media_map
                    case showcase.content.content_media_map.media_map.media.media_type
                      when 1 #Audio
                        type="Audio"
                      when 2 #Video
                        type ="Video"
                      when 3 #Image
                         type="Image"
                    end
                 end
                 message = {title:"New Performance", body:"Checkout #{showcase.user.name}'s #{type} performance \"#{showcase.title}\"", imageUrl: showcase.user.user_media_map.media_map.media_url, bigImageUrl: "", type: "home", id: ""}
                 Notification.init
                 Notification.send(message,ids)
             end
          end
          ActiveRecord::Base.connection.close
      end
      render json: response_map.to_json , status: 200
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
