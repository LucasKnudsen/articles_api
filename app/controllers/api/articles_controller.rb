class Api::ArticlesController < ApplicationController
  def index
    all_articles = Article.all
    render json: {articles: all_articles}
  end

  def show
    article = Article.find(params['id'])
    render json: {article: article}
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  private
 
  def record_not_found
    
    render json: {message: 'We cannot find the article you are looking for.'}, status: 404
    
  end

end

# Write a test with an it block. get 'path'
# Setting the routes. 
# Create the controller. rails g controller 
# Create the action. Binding pry
# Now we need to make mocks in the test.