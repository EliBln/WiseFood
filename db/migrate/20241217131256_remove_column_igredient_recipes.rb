class RemoveColumnIgredientRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :ingredient, :string
  end
end
