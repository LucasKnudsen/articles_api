RSpec.describe 'POST /api/auth', type: :request do
  describe 'successful registration' do
    before do
      post '/api/auth',
           params: {
             email: 'my@email.com',
             password: 'password',
             password_confirmation: 'password'

           }
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'response with a success status message' do
      expect(response_json['status']).to eq 'success'
    end

    describe 'user can sign in to new account' do
      before do
        post '/api/auth/sign_in',
             params: {
               email: 'my@email.com',
               password: 'password'
             }
      end

      it 'responds with a 200 status' do
        expect(response).to have_http_status 200
      end

      it 'responds with expected response' do
        expected_response = {
          'data' => {
            'id' => response_json['data']['id'], 'uid' => 'my@email.com', 'email' => 'my@email.com',
            'provider' => 'email', 'allow_password_change' => false
          }
        }
        expect(response_json).to eq expected_response
      end
    end
  end
end
