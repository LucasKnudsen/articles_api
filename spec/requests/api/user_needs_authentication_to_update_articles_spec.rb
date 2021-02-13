require 'rails_helper'
include ActionController::RespondWith

RSpec.describe 'PUT /api/articles', types: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:article) { create(:article, title: "Needs changing", body: "Bad draft, very bad..")}

  describe 'Authenticated PUT request' do
    before do
      put "/api/articles/#{article.id}",
           params: {
             article: {
               title: 'Im also logged in, therefor I can change',
               body: 'Perfect draft coming up..'
             }
           },
           headers: user_credentials
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with an access-token' do
      expect(response.has_header?('access-token')).to eq(true)
    end

    it 'responds with expected message' do
      expect(response_json['response']['message']).to eq "Successfully updated article: #{article.id}"
    end
  end

  describe 'Unauthenticated PUT request' do
    before do
      put "/api/articles/#{article.id}",
      params: {
        article: {
          title: 'Im also logged in, therefor I can change',
          body: 'Perfect draft coming up..'
        }
      }
    end

    it 'responds with a 401' do
      expect(response).to have_http_status 401
    end

    it 'responds with an appropriate error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
