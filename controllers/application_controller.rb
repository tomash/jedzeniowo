require 'sinatra/base'
require 'sinatra/flash'

load './helpers/application_helper.rb'


class ApplicationController < Sinatra::Base

  set :app_file, 'diet_app'

  enable :method_override
  enable :sessions
  register Sinatra::Flash

  helpers ApplicationHelper

  before do
    @title ||= "Jedzeniowo"
  end

end


