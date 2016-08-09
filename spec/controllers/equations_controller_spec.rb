require 'rails_helper'

RSpec.describe EquationsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #auth" do
    it "returns http success" do
      get :auth
      expect(response).to have_http_status(:success)
    end
  end

end
