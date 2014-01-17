require 'sqlite3'
require 'sinatra/base'
require 'active_record'
require 'sinatra/activerecord'

class Profile < ActiveRecord::Base
  validates_presence_of :name, :age, :sex, :weight, :height, :activity_level
end

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'jedzeniowo.sqlite3.db'
)
