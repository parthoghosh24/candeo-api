class Api::V1::UsersController < ApplicationController

 #POST /api/v1/users/login - User Login
  def login
  end

  #POST /api/v1/users/logout - User Logout
  def logout
  end

  #POST /api/v1/users/register - User Register
  def register
  end

  #GET /api/v1/users/:id - Show User
  def show
    @user= User.find(params[:id])
    user_response={}
    user_response[:username]=@user.username
    user_response[:name]=@user.name
    total_inspired=ResponseMap.where(owner_id:params[:id].to_i, is_inspired:1).size
    total_you_got_inspired=ResponseMap.where(user_id:params[:id].to_i, is_inspired:1).size
    user_response[:total_inspired]=total_inspired
    user_response[:total_you_got_inspired]=total_you_got_inspired
    user_response[:inspiritions]=@user.statuses
    render json: user_response
  end
end
