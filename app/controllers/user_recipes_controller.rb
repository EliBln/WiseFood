class UserRecipesController < ApplicationController
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
