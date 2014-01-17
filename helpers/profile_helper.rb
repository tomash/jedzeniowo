require 'sinatra/base'
require 'sinatra/flash'

module ProfileHelper

  def list_profiles
    Profile.all
  end

  def find_profile
    Profile.find(params[:id])
  end

  def create_profile
    Profile.create(params[:profile])
  end

  def count_activity_factor(profile)
    activity_level = profile.activity_level
    sex = profile.sex.to_i

    male_activity = {1 => 1.3, 2 => 1.4, 3 => 1.6, 4 => 1.7, 5 => 1.9, 6 => 2.0}
    female_activity = {1 => 1.2, 2 => 1.4, 3 => 1.5, 4 => 1.6, 5 => 1.8, 6 => 1.9}

    activity_factor = case sex
      when 1 then female_activity[activity_level]
      when 2 then male_activity[activity_level]
    end

    activity_factor
  end

  def count_calories_need(profile)
    weight = profile.weight
    height = profile.height
    age = profile.age
    sex = profile.sex.to_i

    activity_factor = count_activity_factor(profile)
    age_range = (profile.age > 29 ? "younger" : "older")

    age_factors = case sex
      when 2 then (age_range == "younger" ? [15.1, 692] : [11.5, 873])
      when 1 then (age_range == "younger" ? [14.8, 487] : [8.3, 846])
    end

    multi_factor = case sex
      when 2 then 5
      when 1 then -161
    end

    bmr_1 = ((9.99 * weight) + (6.25 * height) + (4.92 * age) + multi_factor) * activity_factor
    bmr_2 = (weight * age_factors[0] + age_factors[1]) * activity_factor
    bmr = (bmr_1 + bmr_2) / 2

    bmr.round(2)
  end

  def count_protein_need(profile)
    sex = profile.sex.to_i
    activity = profile.activity_level
    protein_per_activity_level = {2 => {1 => 1.2, 2 => 1.3, 3 => 1.4, 4 => 1.5, 5 => 1.7, 6 => 2.0},
                                  1 => {1 => 1.0, 2 => 1.1, 3 => 1.2, 4 => 1.3, 5 => 1.5, 6 => 1.8}}
    protein_need = profile.weight * protein_per_activity_level[sex][activity]
    protein_need.round(2)
  end

  def count_fat_need(profile)
    calories = count_calories_need(profile)
    fat_need = (0.32 * calories) / 9.0
    fat_need.round(2)
  end

  def count_carbs_need(profile)
    calories = count_calories_need(profile)
    proteins = count_protein_need(profile) * 4.0
    fat = count_fat_need(profile) * 9.0
    carbs = (calories - (proteins + fat)) / 4.0
    carbs.round(2)
  end

  def update_profile_with_needs(profile)
    profile.update(calories_need: count_calories_need(profile),
                   protein_need: count_protein_need(profile),
                   fat_need: count_fat_need(profile),
                   carbs_need: count_carbs_need(profile))
  end

end
