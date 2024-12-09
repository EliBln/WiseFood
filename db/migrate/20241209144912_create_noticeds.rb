class CreateNoticeds < ActiveRecord::Migration[7.1]
  def change
    create_table :noticeds do |t|
      t.references :users, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
