class CreateProfiles < ActiveRecord::Migration
  def up
    create_table :profiles do |p|
      p.string :name
      p.integer :sex
      p.integer :age
      p.integer :weight
      p.integer :height
      p.integer :activity_level
      p.float :calories_need
      p.float :protein_need
      p.float :fat_need
      p.float :carbs_need

      p.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
