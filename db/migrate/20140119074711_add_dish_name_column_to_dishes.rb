class AddDishNameColumnToDishes < ActiveRecord::Migration
  def up
    add_column :dishes, :dish_name, :string
  end

  def down
    remove_column :dishes, :dish_name
  end
end
