require 'rails_helper'

RSpec.describe Api::V1::ActivitiesController, :type => :controller do

  describe "GET list" do
    it "returns http success" do
      get :list
      expect(response).to have_http_status(:success)
    end
  end

end
