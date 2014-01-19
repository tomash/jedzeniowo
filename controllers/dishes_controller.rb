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
    @dish = create_dish
    if @dish
      @ingredient = Ingredient.create(
        dish_id: @dish.id,
        quantity_per_dish: params[:ingredient][:quantity_per_dish],
        product_id: Product.where("name = ?",
          params[:ingredient][:name]).id
      )
      @dish.ingredient_id = @ingredient.id
      flash[:notice] = "Danie dodane do listy."
      redirect to("/#{@dish.id}")
    else
      erb :"dishes/dish_new"
    end
  end

  get '/new' do
    @dish = Dish.new
    @ingredient = Ingredient.new(dish_id: @dish.id)
    @products = Product.all
    erb :"dishes/dish_new"
  end

  get '/:id' do
    @dish = find_dish
    erb :"dishes/dish_show"
  end

  get '/:id/edit' do
    @dish = find_dish
    erb :"dishes/dish_edit"
  end

  put '/:id' do
    dish = find_dish
    if dish.update(params[:dish])
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
