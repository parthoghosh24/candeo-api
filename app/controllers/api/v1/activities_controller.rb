class Api::V1::ActivitiesController < ApplicationController

  #GET /api/v1/activities - Fetches all activities
  def list
    @activities = ActivityLog.all    
    render json: @activities
  end
end
