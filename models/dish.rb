require 'sqlite3'
require 'sinatra/base'
require 'active_record'
require 'sinatra/activerecord'

class Dish < ActiveRecord::Base

end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'jedzeniowo.sqlite3.db'
)
