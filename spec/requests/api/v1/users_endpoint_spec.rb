require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before { get '/api/v1/users' }
    it 'shows list of users' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:ok)
    end
  end
  describe 'POST /users' do
    it 'create user' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/v1/users',
           params: { user: { email: 'test@example.com', first_name: 'Test', last_name: 'User', avatar: 'http://example.com' } }, headers: headers
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:created)
    end
  end
  describe 'GET /users/:id' do
    let(:auth) { basic_auth 'user', 'password' }
    it 'show user' do
      post '/api/v1/users',
           params: { user: { email: 'test@example.com', first_name: 'Test', last_name: 'User', avatar: 'http://example.com' } }, headers: headers
      user_id = User.last.id
      get "/api/v1/users/#{user_id}", as: :json, headers: { 'HTTP_AUTHORIZATION' => auth }
      puts response.body
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:ok)
    end
  end
end
