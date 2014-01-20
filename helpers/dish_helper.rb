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

  def create_ingredient(dish, products)
    dish_product = products.where("name =?", params[:product][:name]).first
    ingredient = dish.ingredients.build(
      quantity_per_dish: params[:ingredient][:quantity_per_dish]
    )
    ingredient.update(product_id: dish_product.id.to_i)
    dish_product.update(ingredient_id: ingredient.id.to_i)
    ingredient
  end

  def find_ingredients_products(ingredients)
    ingredients_collection = {}
    ingredients.each do |ingredient|
      ingredients_collection[ingredient.product.name] = ingredient.quantity_per_dish
    end
    ingredients_collection
  end

end
