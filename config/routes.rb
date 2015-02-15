Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do

    #Media
    match  '/media/create', to:'media#create', via:'post', as: :media_create

    #Redirects
    match  '/:code', to:'redirects#show', via:'get', as: :redirect

    #Activities
    match  '/activities', to:'activities#list', via:'get', as: :activities

    #Users
    match  '/users/:id', to:'users#show', via:'get', as: :user
    match  '/users/login', to:'users#login', via:'post', as: :login
    match  '/users/register', to:'users#register', via:'post', as: :register
    match  '/users/verify', to:'users#verify', via:'post',as: :verify

    #Contents
    match '/contents/performances/show', to:'contents#get_performances_map', via:'get',as: :performance_map
    match '/contents/performances/list/:rank', to:'contents#list_performances', via:'get', as: :performances
    match '/contents/limelight/:id', to:'contents#limelight', via:'get', as: :limelight
    match '/contents/limelights/list/:user_id', to:'contents#list_limelight', via:'get', as: :list_limelight
    match  '/contents', to:'contents#list', via:'get', as: :contents
    match '/contents/check/tag/:tag', to:'contents#check_tag_exists', via:'post', as: :contents_tag_exists
    match '/contents/upload', to:'contents#upload', via:'post', as: :upload
    match '/contents/create', to:'contents#create', via: 'post', as: :create_content
    match '/contents/responses/inspire', to:'responses#inspire', via:'post', as: :get_inspired
    match '/contents/responses/appreciate', to:'responses#appreciate', via:'post', as: :appreciate
    match '/contents/responses/skip', to:'responses#skip', via:'post', as: :skip
    match  '/contents/:id/:type', to:'contents#show', via:'get', as: :content

    end
  end
end
