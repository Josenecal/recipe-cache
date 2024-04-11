class CreateRecipeSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_steps do |t|
      t.belongs_to :recipe
      t.string :description
      t.integer :step_number
      t.timestamps
    end
  end
end
