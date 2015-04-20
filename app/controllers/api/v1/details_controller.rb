class Api::V1::DetailsController < ApplicationController
  respond_to :json

  def show
    respond_with Detail.find(params[:id])
  end

  def route_details
    respond_with Detail.where(route_id: params[:id])
  end

  def index
    respond_with Detail.all
  end

end