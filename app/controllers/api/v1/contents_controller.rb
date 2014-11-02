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
      contentData[:username]=content.user.username
      contentData[:time]=distance_of_time_in_words(Time.now, content.created_at)+" ago"
      contents.push(contentData)
    end
    contentMap[:contents]=contents
    render json: contentMap
  end

  #GET /api/v1/contents/:id - Show Content Detail Screen
  def show
    content = Content.find(params[:id])
    contentMap={}
    if content
        contentMap[:media]=nil
        contentMap[:media_type]=0
        if content.media
          case content.media.media_type
          when 1
              contentMap[:media]=content.media.audio.url
          when 2
              contentMap[:media]=content.media.video.url
           when 3
              contentMap[:media]=content.media.image.url
          end
          contentMap[:media_type]=content.media.media_type
        end


        contentMap[:id]=content.id
        contentMap[:desc]=content.description
        contentMap[:user_id]=content.user.id
        contentMap[:user]=content.user.username
    end
    render json: contentMap
  end

 #POST  /api/v1/contents/upload - Upload media
  def  upload
    puts params
    media=nil
    case params[:type].to_i
    when 1 #audio
       media = Media.create(audio:params[:file])
    when 2 #video
       media = Media.create(video:params[:file])
    when 3 #image
       media = Media.create(image:params[:file])
    end

    content = Content.create(description:params[:description])
    user=User.find(params[:user_id])
    content.user=user
    content.media=media
    user_status=user.statuses.create(mode:1)
    user_status.content=content
  end
end
