class Api::V1::DetailsController < ApplicationController
  respond_to :json

  def show
    respond_with Detail.find(params[:id])
  end

end