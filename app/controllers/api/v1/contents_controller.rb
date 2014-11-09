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
    contentMap=Content.show(params)
    render json: contentMap
  end

 #POST  /api/v1/contents/upload - Upload media
  def  upload
    puts params
    Content.upload(params)
  end
end
