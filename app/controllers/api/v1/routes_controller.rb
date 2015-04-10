class Api::V1::RoutesController < ApplicationController
  respond_to :json

  def show
    respond_with Route.find(params[:id])
  end

end