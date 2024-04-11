class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  TABLE_NAME = 'recipe_ingredients'
  def change
    create_table TABLE_NAME do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient, null: true
      t.string :name
      t.float :ammount
      t.string :preparation
      t.timestamps
    end
  end
end
