class Recipe < ApplicationRecord
    has_many :user_recipes
    has_many :users, through: :user_recipes
    # has_many: :recipe_attempts
    # has_many :attempts, through: :recipe_attempts
    has_many :recipe_ingredients, inverse_of: :recipe
    has_many :ingredients, through: :recipe_ingredients
    has_many :recipe_steps

    accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :user_recipes, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :recipe_steps, reject_if: :all_blank, allow_destroy: true

    def link_name
        if description
            "#{name} - #{description[0..50]}"
        else
            name
        end
    end
end
