class AddForeignKeyUserToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :users, null: false, foreign_key: true
  end
end
