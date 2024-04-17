class RecipesController < ApplicationController

    def index
        @user_recipes = current_user.recipes
    end

    def new
        @recipe = Recipe.new
        @recipe.recipe_ingredients.new
        @recipe.user_recipes.new
        @recipe.recipe_steps.new
        @user = current_user
    end

    def create
        new_recipe = order_children(Recipe.new(new_recipe_params))
        if new_recipe.save
            flash[:message] = "Recipe Created!"
            redirect_to "/recipes"
        else
            flash[:error] = "Hmmm, something went wrong. Sorry about that! Pleast try again."
            redirect_to "/recipes/new"
        end
    end

    def show
        @recipe = Recipe.includes(:recipe_steps, :recipe_ingredients).find_by(id: params[:id])
        if @recipe.nil?
            flash[:error] = "Sorry, we can't seem to find that recipe right now."
            redirect_to "/recipes"
        end
    end

    def edit
        @user = current_user
        @recipe = Recipe.find_by(id: params[:id])
        if @recipe.nil?
            flash[:error] = "We can't seem to find the recipe you want to edit. Sorry about that."
            redirect_to "/recipes"
        end
    end

    private

    def new_recipe_params
        params.require(:recipe).permit(
            :name,
            :description,
            recipe_ingredients_attributes: [:id, :name, :ammount, :preparation, :_destroy],
            user_recipes_attributes: [:user_id],
            recipe_steps_attributes: [:id, :step_number, :description, :_destroy]
            )
    end

    def order_children(recipe)
        # Currently just for steps, could be for ingredients too?
        i = 1
        recipe.recipe_steps.each do |step|
            step.step_number = i
            i += 1
        end

        recipe
    end
end