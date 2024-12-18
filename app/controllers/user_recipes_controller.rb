class UserRecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = []
    @user_recipes = UserRecipe.where(user_id: current_user.id)
    @user_recipes.each do |user_recipe|
      @recipe = Recipe.find(user_recipe.recipe_id)
      @recipes << @recipe
    end
    @recipes
  end

  def create
    @user_recipe = current_user.user_recipes.build(recipe_id: params[:recipe_id])
    if @user_recipe.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @user_recipe = current_user.user_recipes.find(params[:id])
    if @user_recipe.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
