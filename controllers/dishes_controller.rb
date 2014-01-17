require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/namespace'

load './helpers/dish_helper.rb'
load './models/dish.rb'

class DishesController < ApplicationController

  register Sinatra::Namespace

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
      flash[:notice] = "Danie dodane do listy."
      redirect to("/#{@dish.id}")
    else
      erb :"dishes/dish_new"
    end
  end

  get '/new' do
    @dish = Dish.new
    erb :"dishes/dish_new"
  end

  get '/:id' do
    @dish = find_product
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
