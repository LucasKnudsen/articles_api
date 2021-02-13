RSpec.describe 'POST /api/articles', types: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }

  describe 'Authenticated POST request' do
    before do
      post '/api/articles',
           params: {
             article: {
               title: 'Im logged in!',
               body: 'A long and descriptive story'
             }
           },
           headers: user_credentials
    end

    it 'responds with a 201 status' do
      
      expect(response).to have_http_status 201
    end
  end

  describe 'Unauthenticated POST request' do
    before do
      post '/api/articles',
           params: {
             article: {
               title: 'Im logged in!',
               body: 'A long and descriptive story'
             }
           }
    end

    it 'responds with a 401' do
      binding.pry
      expect(response).to have_http_status 401
    end
  end
end
