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
    match '/users/shout/:id',to:'users#can_shout', via:'get', as: :user_can_shout
    match '/users/:id/appreciations/:timestamp',  to:'users#get_appreciations',via:'get', as: :user_appreciations
    match '/users/:id/inspirations/:timestamp',  to:'users#get_inspirations',via:'get', as: :user_inspirations
    match '/users/:id/fans/:timestamp',  to:'users#get_fans',via:'get', as: :user_fans
    match '/users/:id/shouts/:timestamp', to:'users#get_public_shouts', via:'get', as: :user_public_shouts
    match '/users/:id/promoted/:timestamp',  to:'users#get_promoted',via:'get', as: :user_promoted
    match '/users/:id/showcases/:timestamp',  to:'users#get_showcases',via:'get', as: :user_showcases
    match  '/users/login', to:'users#login', via:'post', as: :login
    match  '/users/register', to:'users#register', via:'post', as: :register
    match  '/users/verify', to:'users#verify', via:'post',as: :verify
    match '/users/gcm',to:'users#update_gcm', via: 'post',as: :update_gcm
    match '/users/update_profile', to:'users#update_profile',via:'post',as: :update_profile
    match '/web/users/:username',to:'users#show_web',via:'get',as: :show_web_profile
    match '/web/users/:id/showcases',to:'users#get_web_showcases',via:'get',as: :get_web_showcases

    #Contents
    match '/contents/test', to:'contents#test', via:'get',as: :test
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
    match '/contents/responses/:type/:content_id', to:'responses#fetch_responses', via:'get', as: :fetch_responses
    match  '/contents/:id/:type/:user_id', to:'contents#show', via:'get', as: :content
    match '/web/contents/:short/:type', to:'contents#show_web',via:'get',as: :content_web

    #Shouts
    match  '/shouts/create', to:'shouts#create', via:'post', as: :shout_create
    match  '/shouts/:id', to:'shouts#show', via:'get', as: :shout_show
    match  '/shouts/list/:id', to:'shouts#list_shouts', via:'get', as: :list_shouts
    match  '/shouts/network/:id', to:'shouts#list_network', via:'get', as: :list_network
    match  '/shouts/discussions/create', to:'shouts#create_discussion', via:'post', as: :create_discussion
    match  '/shouts/:id/discussions/:timestamp', to:'shouts#fetch_more_discussions', via:'get', as: :fetch_more_discussions


    end
  end
end
