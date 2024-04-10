class RecipesController < ApplicationController

    def index
    end

    def new
        @new_recipe = Recipe.new
        @new_recipe.recipe_ingredients.new
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

    private

    def new_recipe_params
        params.require(:recipe).permit(:name, :description, recipe_ingredients_attributes: [:id, :name, :ammount, :preparation, :_destroy])
    end
end