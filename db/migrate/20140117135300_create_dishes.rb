class CreateDishes < ActiveRecord::Migration
  def up
    create_table :dishes do |d|
      d.text :steps
      d.float :dish_calories
      d.float :dish_protein
      d.float :dish_fat
      d.float :dish_carbs
      d.integer :product_id
      d.float :product_weight

      d.timestapms
    end
  end

  def down
    drop_table :dishes
  end
end
