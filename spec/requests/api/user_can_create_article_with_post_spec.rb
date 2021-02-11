RSpec.describe 'POST /api/articles', types: :request do
  describe 'successfully' do
    before do
      post '/api/articles', params: {
        article: {
          title: 'My Title',
          body: 'My Body'
        }
      }
    end

    it 'responds with a 201 status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['response']['message']).to eq 'Successfully created new article!'
    end

    it 'is expected to store the article' do
      get '/api/articles'
      expect(response_json['articles'].count).to eq 1
      
    end
    it 'is expected to store params correctly' do
      get '/api/articles'
      expect(response_json['articles'].first['title']).to eq 'My Title'
      expect(response_json['articles'].first['body']).to eq 'My Body'
    end
  end

  describe 'unsuccessfully' do

    describe 'missing title' do
      before do
        post '/api/articles', params: {
          article: {

            body: 'My Body'
          }
        }
      end

      it 'is expected to return a 422 status' do

        expect(response).to have_http_status 422
      end
    end
  end
end
