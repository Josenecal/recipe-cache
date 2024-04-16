class UpdateRecipeIngredientDataTypes < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      change_table :recipe_ingredients do |t|
        direction.up { t.change :ammount, :string }
        direction.down { t.change :amount, :float }
      end
    end
  end
end
