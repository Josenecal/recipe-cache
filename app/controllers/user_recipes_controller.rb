class UserRecipesController < ApplicationController

    def create
        user_recipe = UserRecipe.new(
            recipe_id: params[:id],
            user_id: current_user.id
        )

        if user_recipe.save
            flash[:message] = "Recipe Successfully Saved!"
            redirect_back_or_to "/recipes"
        else
            flash[:error] = "Something went wrong!"
            redirect_back_or_to "/recipes"
        end
    end

end