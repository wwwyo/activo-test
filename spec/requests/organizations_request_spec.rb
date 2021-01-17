require 'rails_helper'

RSpec.describe "Organizations", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/organizations/index"
      expect(response).to have_http_status(:success)
    end
  end

end