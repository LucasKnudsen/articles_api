RSpec.describe 'PUT /api/articles/:id', types: :request do

  let(:article) { create(:article, title: 'Test Title', body: 'Test Body')}
  
  describe 'Test article is correctly created' do
    it 'can get the test article' do
      get "/api/articles/#{article.id}"
      expect(response_json['article']['title']).to eq 'Test Title'
      expect(response_json['article']['body']).to eq 'Test Body'
    end
  end


  describe 'successfully' do
    before do
      put "/api/articles/#{article.id}", params: {
        article: {
          title: 'New Title',
          body: 'New body'
        }
      }
    end

    it 'responds with a 204 status' do
      expect(response).to have_http_status 204
    end

    it 'is expected to return a success message' do
      expect(response_json['response']['message']).to eq "Successfully updated article: #{article.id}"
    end

    it 'is expected to have stored the new data correctly' do
      get '/api/articles'
      expect(response_json['articles'].first['title']).to eq 'New Title'
      expect(response_json['articles'].first['body']).to eq 'New Body'
    end

   
  end
end
