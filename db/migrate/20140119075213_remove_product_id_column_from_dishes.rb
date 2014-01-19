class RemoveProductIdColumnFromDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :product_id
  end

  def down
    add_column :dishes, :product_id, :integer
  end
end
