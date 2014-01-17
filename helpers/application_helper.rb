module ApplicationHelper

  def grams_to_kcal(model_object)

    if model_object.is_a? Product
      protein = model_object.protein.to_f
      fat = model_object.fat.to_f
      carbs = model_object.carbs.to_f
    end

    if model_object.is_a? Profile
      protein = model_object.protein_need.to_f
      fat = model_object.fat_need.to_f
      carbs = model_object.carbs_need.to_f
    end

    protein_kcal = (4 * protein).round(2)
    fat_kcal = (9 * fat).round(2)
    carbs_kcal = (4 * carbs).round(2)

    [protein_kcal, fat_kcal, carbs_kcal]
  end
end
