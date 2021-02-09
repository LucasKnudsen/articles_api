RSpec.describe 'POST requests creates a new article', type: :request do
  describe 'successfully' do
    before do
      post 'api/article'
    end

    it 'responds with a 201 status' do
      expect(response).to have_http_status 201
    end

  end
end
