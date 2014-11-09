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
    user_response = User.show(params)
    render json: user_response
  end
end
