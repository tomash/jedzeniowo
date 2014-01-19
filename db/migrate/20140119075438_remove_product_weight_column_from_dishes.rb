class RemoveProductWeightColumnFromDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :product_weight
  end

  def down
    add_column :dishes, :product_weight, :float
  end
end
