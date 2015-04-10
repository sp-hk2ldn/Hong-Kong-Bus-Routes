require 'spec_helper'

describe Api::V1::RoutesController do
  before(:each) { request.headers['Accept'] = "application/vnd.hkbusroutes.v1, #{Mime::JSON}" }
  before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }


  describe "GET #show" do
    before(:each) do
      @route = FactoryGirl.create :route
      get :show, id: @route.id
    end


    it "returns the information about a reporter on a hash" do
      routes_response = json_response
      expect(routes_response[:route_from_to]).to eql @route.route_from_to
    end
  end



    describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :route }
      get :index
    end

    it "returns 4 records from the db" do
      routes_response = json_response
      expect(routes_response).to have(4).items
    end

    it { should respond_with 200 }
  end
end