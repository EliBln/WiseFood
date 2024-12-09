class CreateUsersRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :users_recipes do |t|
      t.references :users, null: false, foreign_key: true
      t.references :recipes, null: false, foreign_key: true

      t.timestamps
    end
  end
end
