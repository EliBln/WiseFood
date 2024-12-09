class AddColumnDetailToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :detail, :string
  end
end
