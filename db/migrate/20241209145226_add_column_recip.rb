class AddColumnRecip < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :name, :string
    add_column :recipes, :img_url, :string
  end
end
