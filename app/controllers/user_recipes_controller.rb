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

    def destroy
        if params[:user_id].to_i == current_user.id
            user_recipe = UserRecipe.where(recipe_id: params[:recipe_id], user_id: params[:user_id]).destroy_all
            flash[:message] = "Recipe removed from library."
        else
            flash[:error] = "Something went wrong, recipe was not removed"
        end
        redirect_back_or_to "/recipes"
    end

end