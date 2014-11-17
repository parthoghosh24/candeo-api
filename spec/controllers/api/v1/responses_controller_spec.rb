require 'rails_helper'

RSpec.describe Api::V1::ResponsesController, :type => :controller do

  describe "GET inspire" do
    it "returns http success" do
      get :inspire
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET appreciate" do
    it "returns http success" do
      get :appreciate
      expect(response).to have_http_status(:success)
    end
  end

end
