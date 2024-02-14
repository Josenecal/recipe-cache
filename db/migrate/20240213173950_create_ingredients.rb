class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.string :component, default: false
      t.integer :component_recipe_id
      t.timestamps
    end
  end
end
