class RenameRecipesIdToRecipeIdInUserRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_recipes, :recipes_id, :recipe_id
  end
end
