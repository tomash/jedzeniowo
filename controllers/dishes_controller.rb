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

  # TODO: remove this comment after understanding and implementing everything
  # example parameters posted:
  # {
  #   "dish"=>{"dish_name"=>"Danie1234", "steps"=>"xxx"},
  #   "ingredient"=>{
  #     "0"=>{"quantity_per_dish"=>"3"},
  #     "1"=>{"quantity_per_dish"=>"4"},
  #     "2"=>{"quantity_per_dish"=>""},
  #     "3"=>{"quantity_per_dish"=>""},
  #     "4"=>{"quantity_per_dish"=>""}
  #   },
  #   "product"=>{
  #     "0"=>{"name"=>"produkt1"},
  #     "1"=>{"name"=>"produkt2"},
  #     "2"=>{"name"=>"produkt1"},
  #     "3"=>{"name"=>"produkt1"},
  #     "4"=>{"name"=>"produkt1"}
  #   }
  # }
  post '/' do
    @products = Product.all
    @dish = create_dish

    # params[:ingredient] is now a hash
    params[:ingredient].each do |i, quantity_hash|
      # early exit: don't process ingredients with no amount
      next if quantity_hash[:quantity_per_dish].to_f < 1
      # we use the same 'i' for numbering products and quantities-per-dish (good!)
      dish_product = @products.where(name: params[:product][i][:name]).first
      @ingredient = @dish.ingredients.build(
        quantity_per_dish: quantity_hash[:quantity_per_dish]
      )
      @ingredient.update(product_id: dish_product.id.to_i)
    end

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
    @ingredients_collection = {}
    @ingredients.each do |ingredient|
      @ingredients_collection[ingredient.product.name] = ingredient.quantity_per_dish
    end
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
