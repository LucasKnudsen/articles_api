RSpec.describe 'GET /api/articles/:id' , types: :request do
  let(:article) { create(:article, title: 'Today news', body: 'Today body')}
  
  describe 'successfully' do
    before do
      get "/api/articles/#{article.id}"
    end

    it 'is expected to return status 200' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the requested articles titles' do
      expect(response_json['article']['title']).to eq 'Today news'
    end

    it 'is expected to return the requested articles body' do
      expect(response_json['article']['body']).to eq 'Today body'
    end
  end

  describe 'unsuccessfully with invalid id' do
    before do
      get '/api/articles/abc'
    end

    it 'returns a 404' do
      expect(response).to have_http_status 404
    end

    it 'returns an error message' do
      expect(response_json['message']).to eq 'We cannot find the article you are looking for.'
    end
    # raise ActionController::RoutingError, 'bla'
  end

end