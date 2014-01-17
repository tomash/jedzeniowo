require 'sinatra/base'
require 'sinatra/flash'

load './helpers/profile_helper.rb'
load './models/profile.rb'

class ProfilesController < ApplicationController

  helpers ProfileHelper, ApplicationHelper

  get '/' do
    @profiles = list_profiles
    if @profiles.empty?
      redirect to('/new')
    end
    erb :"profiles/profile_list"
  end

  post '/' do
    @profile = create_profile
    if @profile
      flash[:notice] = "Profil dodany do listy."
      update_profile_with_needs(@profile)
      redirect to("/#{@profile.id}")
    else
      erb :"profiles/profile_new"
    end
  end

  get '/new' do
    @profile = Profile.new
    erb :"profiles/profile_new"
  end

  get '/:id' do
    @profile = find_profile
    @sex = (@profile.sex == 1 ? "kobieta" : "mężczyzna")
    @protein_kcal, @fat_kcal, @carbs_kcal = grams_to_kcal(@profile)
    erb :"profiles/profile_show"
  end

  get '/:id/edit' do
    @profile = find_profile
    erb :"profiles/profile_edit"
  end

  put '/:id' do
    profile = find_profile
    if profile.update(params[:profile])
      update_profile_with_needs(profile)
      flash[:notice] = "Profil został zaktualizowany."
    end
    redirect to('/')
  end

  delete '/:id' do
    if find_profile.destroy
      flash[:notice] = "Profil usunięty."
    end
    redirect to('/')
  end
end
