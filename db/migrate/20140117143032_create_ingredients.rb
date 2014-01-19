class CreateIngredients < ActiveRecord::Migration
  def up
    create_table :ingredients do |i|
      i.integer :product_id
      i.integer :dish_id
      i.float :quantity_per_dish

      i.timestamps
    end
  end

  def down
    drop_table :ingredients
  end
end
