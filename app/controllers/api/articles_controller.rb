class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

  def index
    all_articles = Article.all
    render json: { articles: all_articles }
  end

  def show
    article = Article.find(params['id'])
    render json: { article: article }
  end

  def create
    if params[:article][:title] && params[:article][:body]
      new_article = Article.create(create_params)
      render json: { 
        response: { 
        message: 'Successfully created new article!', 
        article: new_article 
        } 
      }, status: 201
    else
      render status: 422
    end
  
  end

  def update
    article = Article.find(params['id'])
    article.update(title: params[:article][:title], body: params[:article][:body])
    render json: {
      response: {
      message: "Successfully updated article: #{article.id}",
      article: article
      }
    }

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
