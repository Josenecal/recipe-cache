class UserRecipesController < ApplicationController

    def create
        user_recipe = UserRecipe.new(
            recipe_id: params[:recipe_id],
            user_id: current_user.id
        )

        puts params

        if user_recipe.save
            flash[:message] = "Recipe Successfully Saved!"
            redirect_back_or_to "/recipes"
        else
            flash[:error] = "Something went wrong!"
            redirect_back_or_to "/recipes"
        end
    end

    def destroy
        user_recipe = UserRecipe.find_by(id: user_recipe_identifier)
        if user_recipe.nil? 
            flash[:error] = "This user recipe no longer exists"
        elsif user_recipe.user_id = current_user.id
            user_recipe.destroy
            flash[:message] = "Recipe Removed"
        else
            flash[:error] = "Something went wrong!"
        end
        redirect_back_or_to "/recipes"
    end

    private

    # Strong params

    def user_recipe_identifier
        params.permit(:id)[:id]
    end


end