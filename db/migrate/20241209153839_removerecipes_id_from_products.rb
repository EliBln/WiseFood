class RemoverecipesIdFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :recipes_id
  end
end
