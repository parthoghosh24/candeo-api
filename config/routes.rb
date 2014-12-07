Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do
    #Activities
    match  '/activities', to:'activities#list', via:'get', as: :activities

    #Users
    match  '/users/:id', to:'users#show', via:'get', as: :user
    match  '/users/login', to:'users#login', via:'post', as: :login
    match  '/users/register', to:'users#register', via:'post', as: :register

    #Contents
    match  '/contents/:id', to:'contents#show', via:'get', as: :content
    match  '/contents', to:'contents#list', via:'get', as: :contents
    match '/contents/check/tag/:tag', to:'contents#check_tag_exists', via:'post', as: :contents_tag_exists
    match '/contents/upload', to:'contents#upload', via:'post', as: :upload
    match '/contents/create', to:'contents#create', via: 'post', as: :create_content
    match '/contents/:id/responses/inspire', to:'responses#inspire', via:'post', as: :get_inspired
    match '/contents/:id/responses/appreciate', to:'responses#appreciate', via:'post', as: :appreciate


    end
  end
end
