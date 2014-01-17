require 'sinatra/base'
require 'sinatra/flash'

load './controllers/products_controller.rb'
load './controllers/profiles_controller.rb'

class BaseController < ApplicationController

  get '/' do
    erb :home
  end

  get '/about' do
    erb :about
  end

  get '/contact' do
    erb :contact
  end

end

