require 'sinatra/base'
require 'sinatra/flash'

module ProductHelper

  def list_products
    Product.all
  end

  def find_product
    Product.find(params[:id])
  end

  def create_product
    Product.create(params[:product])
  end

end
