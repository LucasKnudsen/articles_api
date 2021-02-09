RSpec.describe 'GET /api/articles' do
  describe 'successfully' do
    before do
      get '/api/articles'
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end
    
    it 'is expected to return all articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'is expected to return article titles' do
      expect(response_json['articles'].first['title']).to eq 'BUY CRYPTO TODAY!'
    end
  end
end