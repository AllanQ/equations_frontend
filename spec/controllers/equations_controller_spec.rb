require 'rails_helper'

RSpec.describe EquationsController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #auth' do
    it 'responds with success' do
      get :auth, format: 'js', xhr: true, params: { eq_params: { 'type': 'linear', 'a': 1, 'b': 1, 'c': '' } }
      expect(response.status).to eq(200)
    end
  end
end
