class RecipesController < ApplicationController

    skip_before_action :require_login, only: [:index, :show]

    def index
        if logged_in?
            @authored_recipes = Recipe.where(author_id: current_user.id)
            @user_recipes = current_user.recipes
            @public_recipes = Recipe.where(private: false).where.not(id: @user_recipes.pluck(:recipe_id))
        else
            @public_recipes = Recipe.where(private: false)
        end
    end

    def new
        @recipe = Recipe.new
        @recipe.recipe_ingredients.new
        @recipe.user_recipes.new
        @recipe.recipe_steps.new
        @user = current_user
    end

    def create
        new_recipe = order_children(Recipe.new(new_params))
        new_recipe.author_id = current_user.id
        if new_recipe.save
            flash[:message] = "Recipe Created!"
            redirect_to "/recipes"
        else
            flash[:error] = "Hmmm, something went wrong. Sorry about that! Pleast try again."
            redirect_to "/recipes/new"
        end
    end

    def show
        @recipe = Recipe.includes(:recipe_steps, :recipe_ingredients, :user_recipes).find_by(id: params[:id])
        @user_recipe = @recipe&.user_recipes&.find_by(user_id: current_user&.id)
        if @recipe.nil? || (@recipe.private? && @user_recipe.nil?)
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
        elsif @recipe.author_id != current_user.id
            flash[:error] = "Sorry, you don't have permission to edit that recipe."
            redirect_to "/recipes"
        end
    end

    def update
        recipe = Recipe.includes(:recipe_steps, :recipe_ingredients, :user_recipes).find_by(id: update_params[:id])
        
        if recipe.update(update_params)
            flash[:message] = "Update Successful"
            redirect_to "/recipes"
        else
            flash[:error] = "It broke :/"
            redirect_to "/recipes"
        end
    end

    def destroy
        recipe = Recipe.includes(:recipe_steps, :recipe_ingredients, :user_recipes).find_by(id: recipe_id_param)

        if recipe && current_user.can_delete?(recipe)
            recipe.destroy
            redirect_to root_path
        else
            flash[:error] = "permission denied"
            redirect_back_or_to root_path
        end
    end

    private

    def new_params
        params.require(:recipe).permit(
            :name,
            :description,
            :private,
            recipe_ingredients_attributes: [:name, :ammount, :preparation, :_destroy],
            user_recipes_attributes: [:user_id],
            recipe_steps_attributes: [:step_number, :description, :_destroy]
            )
    end

    def update_params
        params.require(:recipe).permit(
            :id,
            :name,
            :description,
            :private,
            :_destroy,
            recipe_ingredients_attributes: [:id, :name, :ammount, :preparation, :_destroy],
            user_recipes_attributes: [:id, :user_id],
            recipe_steps_attributes: [:id, :step_number, :description, :_destroy]
            )
    end

    def recipe_id_param
        params.permit(:id)[:id].to_i
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