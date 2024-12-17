class DropUsersRecipes < ActiveRecord::Migration[7.1]
  def change
    drop_table :users_recipes
  end
end
