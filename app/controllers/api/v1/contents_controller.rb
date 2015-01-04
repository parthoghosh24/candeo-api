class Api::V1::ContentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include ActionView::Helpers::DateHelper
  #GET /api/v1/contents - Fetches Contents for Feed Screen
  def list
    require 'action_view'
    contentMap ={}
    contents=[]
    Content.all.order(created_at: :desc).each do |content|
      contentData={}
      contentData[:id]=content.id
      contentData[:desc]=content.description
      contentData[:name]=content.user.name
      contentData[:time]=distance_of_time_in_words(Time.now, content.created_at)+" ago"
      contentData[:media_type]= content.media ? content.media.media_type : 0
      contents.push(contentData)
    end
    contentMap[:contents]=contents
    render json: contentMap, status: 200
  end

  #GET /api/v1/contents/:id - Show Content Detail Screen
  def show
    contentMap=Content.show(params)
    render json: contentMap, status: 200
  end

  #POST  /api/v1/contents/create - Create Content
  def create
    puts params
    case params[:type].to_i
    when 1 #status
       id=Status.create_status(params)
    when 2 #showcase
       id=Showcase.create_showcase(params)
    end

    if !id.blank?
      response_map={:id=> id}
      puts response_map.to_json
      render json: response_map.to_json , status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

  #POST /api/v1/contents/:id - Update Content
  def update
    puts params
    case params[:type].to_i
    when 1 #Status
      id=nil
    when 2 #Showcase
      id=Showcase.update_showcase(params)
    end
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

end
