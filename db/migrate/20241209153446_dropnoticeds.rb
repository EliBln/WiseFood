class Dropnoticeds < ActiveRecord::Migration[7.1]
  def change
    drop_table :noticeds
  end
end
