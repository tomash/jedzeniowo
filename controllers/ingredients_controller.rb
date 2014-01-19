require 'sinatra/base'
require 'sinatra/flash'

load './helpers/product_helper.rb'
load './models/product.rb'
load './models/ingredient.rb'

class IngredientsController < ApplicationController

  helpers ApplicationHelper

end
