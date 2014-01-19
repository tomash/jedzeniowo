require 'sinatra/base'

require './controllers/application_controller.rb'
require './controllers/base_controller.rb'
require './controllers/products_controller.rb'
require './controllers/profiles_controller.rb'
require './controllers/articles_controller.rb'
require './controllers/dishes_controller.rb'


map('/products') {run ProductsController}
map('/profiles') {run ProfilesController}
map('/articles') {run ArticlesController}
map('/dishes') {run DishesController}


map('/') {run BaseController}
