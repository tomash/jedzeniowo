require 'sqlite3'
require 'sinatra/base'
require 'active_record'
require 'sinatra/activerecord'

class Product < ActiveRecord::Base
  validates_presence_of :name
  has_many :ingredients, dependent: :destroy
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'jedzeniowo.sqlite3.db'
)
