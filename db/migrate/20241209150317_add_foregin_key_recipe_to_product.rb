class AddForeginKeyRecipeToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :recipes, null: false, foreign_key: true
  end
end
