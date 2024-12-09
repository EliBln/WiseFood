class AddColumnProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :name, :string
    add_column :products, :expiration_date, :date
    add_column :products, :quantity_stock, :string
  end
end
