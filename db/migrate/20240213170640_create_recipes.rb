class CreateRecipes < ActiveRecord::Migration[7.1]
  TABLE_NAME = 'recipes'
  def change
    create_table TABLE_NAME do |t|
      t.string 'name'
      t.string 'description'
      t.integer 'parent_recipe'
      t.timestamps
    end
  end
end
