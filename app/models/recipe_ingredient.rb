class RecipeIngredient < ApplicationRecord

    belongs_to :recipe, :ingredient

end