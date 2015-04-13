require 'api_constraints'

Busroutes::Application.routes.draw do
  get 'welcome/index'

  devise_for :users
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :routes, :only => [:show, :index, :route_from]
      resources :users, :only => [:show]
      resources :details, :only => [:show]
    end
  end

  root 'welcome#index'
end