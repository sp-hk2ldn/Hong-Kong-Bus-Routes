require 'api_constraints'

Busroutes::Application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :routes, :only => [:show, :index]
      resources :users, :only => [:show]
      resources :details, :only => [:show]
    end
  end

end