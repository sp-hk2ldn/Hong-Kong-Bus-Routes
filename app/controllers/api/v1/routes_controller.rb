class Api::V1::RoutesController < ApplicationController
  respond_to :json

  def show
    respond_with Route.find(params[:id])
  end

  def create
    route = Route.new(route_params)
    if route.save
      render json: route, status: 201, location: [:api, route]
    else
      render json: { errors: route.errors }, status: 422
    end
  end

  def index
    respond_with Route.all
  end

  def route_from_all
    respond_with Route.pluck("from_where")
  end

  def route_from
    respond_with Route.find(params[:id]).from_where
  end

  def route_params
    params.require(:route).permit(:route_from_to, :cost, :special, :direction)
  end

end