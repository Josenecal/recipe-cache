class Recipe < ApplicationRecord
    has_many :user_recipes
    has_many :users, through: :user_recipes, dependent: :destroy
    # has_many: :recipe_attempts
    # has_many :attempts, through: :recipe_attempts
    has_many :recipe_ingredients, inverse_of: :recipe, dependent: :destroy
    has_many :ingredients, through: :recipe_ingredients
    has_many :recipe_steps, dependent: :destroy

    belongs_to :author, class_name: 'User', foreign_key: 'author_id'

    accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :user_recipes, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :recipe_steps, reject_if: :all_blank, allow_destroy: true

    def private?
        private
    end

    def authored_by?(user_id)
        author_id == user_id
    end
    
    def link_name
        if description
            "#{name} - #{description}"[0..50]
        else
            name
        end
    end
end
