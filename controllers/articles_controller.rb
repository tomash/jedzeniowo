require 'sinatra/base'
require 'sinatra/flash'

load './helpers/article_helper.rb'
load './models/article.rb'

class ArticlesController < ApplicationController

  helpers ArticleHelper, ApplicationHelper

  get '/' do
    @articles = list_articles
    if @articles.empty?
      redirect to('/new')
    end
    erb :"articles/article_list"
  end

  post '/' do
    @article = create_article
    if @article
      flash[:notice] = "Artykuł dodany do bazy."
      redirect to("/#{@article.id}")
    else
      erb :"articles/article_new"
    end
  end

  get '/new' do
    @article = Article.new
    erb :"articles/article_new"
  end

  get '/:id' do
    @article = find_article
    erb :"articles/article_show"
  end

  get '/:id/edit' do
    @article = find_article
    erb :"articles/article_edit"
  end

  put '/:id' do
    product = find_article
    if article.update(params[:article])
      flash[:notice] = "Artykuł został zaktualizowany."
    end
    redirect to('/')
  end

  delete '/:id' do
    if find_article.destroy
      flash[:notice] = "Artykuł usunięty."
    end
    redirect to('/')
  end
end
