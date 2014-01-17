require 'sinatra/base'
require 'sinatra/flash'

module ArticleHelper

  def list_articles
    Article.all
  end

  def find_article
    Article.find(params[:id])
  end

  def create_article
    Article.create(params[:article])
  end

end
