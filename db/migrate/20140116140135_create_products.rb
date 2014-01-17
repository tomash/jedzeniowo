class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |p|
      p.string :name
      p.integer :calories
      p.float :protein
      p.float :fat
      p.float :carbs

      p.timestamps
    end
  end

  def down
    drop_table :products
  end
end
