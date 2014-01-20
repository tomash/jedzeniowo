require 'sinatra/base'
require 'sinatra/flash'

load './helpers/dish_helper.rb'
load './models/dish.rb'
load './models/ingredient.rb'
load './models/product.rb'

class DishesController < ApplicationController

  helpers DishHelper, ApplicationHelper

  get '/' do
    @dishes = list_dishes
    if @dishes.empty?
      redirect to('/new')
    end
    erb :"dishes/dish_list"
  end

  post '/' do
    @products = Product.all
    @dish = create_dish
    @ingredient = create_ingredient(@dish, @products)
    if @dish
      flash[:notice] = "Danie dodane do listy."
      redirect to("/#{@dish.id}")
    else
      erb :"dishes/dish_new"
    end
  end

  get '/new' do
    @dish = Dish.new
    @products = Product.all
    @ingredient = Ingredient.new
    erb :"dishes/dish_new"
  end

  get '/:id' do
    @dish = find_dish
    @ingredients = @dish.ingredients
    @ingredients_collection = find_ingredients_products(@ingredients)
    erb :"dishes/dish_show"
  end

  get '/:id/edit' do
    @dish = find_dish
    @products = Product.all
    @ingredient = @dish.ingredients.first
    erb :"dishes/dish_edit"
  end

  put '/:id' do
    @dish = find_dish
    @products = Product.all
    @ingredient = @dish.ingredients
    if @dish.update(params[:dish])
      dish_product = @products.where("name =?", params[:product][:name]).first
      @ingredient.first.update(quantity_per_dish: params[:ingredient][:quantity_per_dish], product_id: dish_product.id.to_i)
      dish_product.update(ingredient_id: @ingredient.first.id.to_i)
      flash[:notice] = "Danie zostało zaktualizowane."
    end
    redirect to('/')
  end

  delete '/:id' do
    if find_dish.destroy
      flash[:notice] = "Danie usunięte."
    end
    redirect to('/')
  end

end
