class UserRecipesController < ApplicationController
  def index
    @favorite_recipes = current_user.recipes
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @user_recipe = UserRecipe.new(recipe_id: @recipe.id, user_id: current_user.id)
    @user_recipe.save
  end

  def destroy
    @user_recipe = current_user.user_recipes.find(params[:id])
    if user_recipe.destroy
      redirect_to user_recipes_path, notice: "Recette retirée des favoris"
    else
      redirect_to user_recipes_path, alert: "Une erreur est survenue"
    end
  end
end
