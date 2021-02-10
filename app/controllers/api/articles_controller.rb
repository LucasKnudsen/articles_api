class Api::ArticlesController < ApplicationController
  def index
    all_articles = Article.all
    render json: { articles: all_articles }
  end

  def show
    article = Article.find(params['id'])
    render json: { article: article }
  end

  def create

    new_article = Article.create(create_params)
    render json: 
      { response: { 
        message: 'Successfully created new article!', 
        article: new_article 
        } 
      }, status: 201
    
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def create_params
    params.require(:article).permit(:title, :body)
  end

  def record_not_found
    render json: { message: 'We cannot find the article you are looking for.' }, status: 404
  end
end

# Write a test with an it block. get 'path'
# Setting the routes.
# Create the controller. rails g controller
# Create the action. Binding pry
# Now we need to make mocks in the test.
