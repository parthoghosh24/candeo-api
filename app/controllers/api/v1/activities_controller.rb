class Api::V1::ActivitiesController < ApplicationController

  #GET /api/v1/activities - Fetches all activities
  def list
    @activities = ActivityLog.where(activity_type:[1,3]).order(created_at: :desc)
    render json: @activities
  end
end
