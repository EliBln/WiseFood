class DropUsersRecipesSeconTime < ActiveRecord::Migration[7.1]
  def up
    if table_exists? :user_recipes
      drop_table :user_recipes
    end
  end
end
