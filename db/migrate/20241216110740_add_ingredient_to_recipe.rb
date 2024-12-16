class AddIngredientToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :ingredient, :string
  end
end
