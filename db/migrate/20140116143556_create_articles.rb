class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |a|
      a.string :title
      a.text :content
      a.string :author
      a.string :source

      a.timestamps
    end
  end

  def down
    drop_table :articles
  end
end
