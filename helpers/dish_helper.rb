require 'sinatra/base'
require 'sinatra/flash'

module DishHelper

  def list_dishes
    Dish.all
  end

  def find_dish
    Dish.find(params[:id])
  end

  def create_dish
    Dish.create(params[:dish])
  end

end
