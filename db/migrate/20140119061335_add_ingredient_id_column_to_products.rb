class AddIngredientIdColumnToProducts < ActiveRecord::Migration
  def up
    add_column :products, :ingredient_id, :integer
  end

  def down
    remove_column :products, :ingredient_id
  end
end
