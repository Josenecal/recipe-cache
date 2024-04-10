class RecipesController < ApplicationController

    def index
    end

    def new
        @new_recipe = Recipe.new
    end

end