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
    match '/users/posted/:id',to:'users#has_posted', via:'get', as: :user_has_posted
    match '/users/:id/appreciations/:timestamp',  to:'users#get_appreciations',via:'get', as: :user_appreciations
    match '/users/:id/inspirations/:timestamp',  to:'users#get_inspirations',via:'get', as: :user_inspirations
    match '/users/:id/fans/:timestamp',  to:'users#get_fans',via:'get', as: :user_fans
    match '/users/:id/promoted/:timestamp',  to:'users#get_promoted',via:'get', as: :user_promoted
    match '/users/:id/showcases/:timestamp',  to:'users#get_showcases',via:'get', as: :user_showcases
    match  '/users/login', to:'users#login', via:'post', as: :login
    match  '/users/register', to:'users#register', via:'post', as: :register
    match  '/users/verify', to:'users#verify', via:'post',as: :verify

    #Contents
    match '/contents/performances/show', to:'contents#get_performances_map', via:'get',as: :performance_map
    match '/contents/performances/list/:rank', to:'contents#list_performances', via:'get', as: :performances
    match '/contents/limelight/:id', to:'contents#limelight', via:'get', as: :limelight
    match '/contents/limelights/list/:user_id', to:'contents#list_limelight', via:'get', as: :list_limelight
    match '/contents/check/tag/:tag', to:'contents#check_tag_exists', via:'post', as: :contents_tag_exists
    match '/contents/upload', to:'contents#upload', via:'post', as: :upload
    match '/contents/create', to:'contents#create', via: 'post', as: :create_content
    match '/contents/responses/inspire', to:'responses#inspire', via:'post', as: :get_inspired
    match '/contents/responses/appreciate', to:'responses#appreciate', via:'post', as: :appreciate
    match '/contents/responses/skip', to:'responses#skip', via:'post', as: :skip
    match  '/contents/:id/:type/:user_id', to:'contents#show', via:'get', as: :content

    end
  end
end
