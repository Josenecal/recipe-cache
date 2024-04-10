class RecipesController < ApplicationController

    def index
        @user_recipes = current_user.recipes
    end

    def new
        @new_recipe = Recipe.new
        @new_recipe.recipe_ingredients.new
        @new_recipe.user_recipes.new
        @user = current_user
    end

    def create
        @new_recipe = Recipe.new(new_recipe_params)
        if @new_recipe.save
            flash[:message] = "Recipe Created!"
            redirect_to "/recipes"
        else
            flash[:error] = "Hmmm, something went wrong. Sorry about that! Pleast try again."
            redirect_to "/recipes/new"
        end
    end

    def show

    end

    private

    def new_recipe_params
        params.require(:recipe).permit(:name, :description, recipe_ingredients_attributes: [:id, :name, :ammount, :preparation, :_destroy], user_recipes_attributes: [:user_id])
    end
end