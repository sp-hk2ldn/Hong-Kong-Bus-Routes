require 'api_constraints'

Busroutes::Application.routes.draw do
  get 'welcome/index'

  devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # resources :routes, :only => [:show, :index, :route_from]
      resources :routes, :only => [:show, :index, :route_from, :route_from_all] do
        get 'route_from',         on: :member
        get 'route_to',           on: :collection
        get 'route_from_all',     on: :collection
      end
      resources :users, :only => [:show]
      resources :details, :only => [:show, :route_details, :index] do
        get 'route_details',      on: :member
      end
    end
  end

  root 'welcome#index'
end