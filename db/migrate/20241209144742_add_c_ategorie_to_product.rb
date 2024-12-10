class AddCAtegorieToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :categorie, null: false, foreign_key: true
  end
end
