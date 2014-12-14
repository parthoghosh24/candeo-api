class Api::V1::ResponsesController < ApplicationController

  #POST /contents/:id/responses/inspire - Getting inspired from content
  def inspire
    id=ResponseMap.get_inspired(params)
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end

#POST /contents/:id/responses/appreciate - Appreciating Content
  def appreciate
    id=ResponseMap.appreciate(params)
    if !id.blank?
      response_map={:id=> id}
      render json: response_map, status: 200
    else
      render json:{:response=>"failed"}, status:422
    end
  end
end
