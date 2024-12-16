class AddColumAndRemoveForRecipe < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :img_url, :string
    add_column :recipes, :ingredients, :string
  end
end
