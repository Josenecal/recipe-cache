class Recipe < ApplicationRecord
    has_many :users, through: :user_recipes
    has_many :attempts, through: :recipe_attempts
    has_many :ingredients, through: :recipe_ingredients
end
