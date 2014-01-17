require 'sinatra/base'
require 'sinatra/flash'

load './helpers/product_helper.rb'
load './models/product.rb'

class ProductsController < ApplicationController

  helpers ProductHelper, ApplicationHelper

  get '/' do
    @products = list_products
    if @products.empty?
      redirect to('/new')
    end
    erb :"products/product_list"
  end

  post '/' do
    @product = create_product
    if @product
      flash[:notice] = "Produkt dodany do listy."
      redirect to("/#{@product.id}")
    else
      erb :"products/product_new"
    end
  end

  get '/new' do
    @product = Product.new
    erb :"products/product_new"
  end

  get '/:id' do
    @product = find_product
    @protein_kcal, @fat_kcal, @carbs_kcal = grams_to_kcal(@product)
    erb :"products/product_show"
  end

  get '/:id/edit' do
    @product = find_product
    erb :"products/product_edit"
  end

  put '/:id' do
    product = find_product
    if product.update(params[:product])
      flash[:notice] = "Produkt został zaktualizowany."
    end
    redirect to('/')
  end

  delete '/:id' do
    if find_product.destroy
      flash[:notice] = "Produkt usunięty."
    end
    redirect to('/')
  end
end
