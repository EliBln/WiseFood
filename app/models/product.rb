class Product < ApplicationRecord
  belongs_to :categorie
  belongs_to :user

  validates :name, presence: true
  validates :expiration_date, presence: true
  validates :quantity_stock, numericality: { greater_than_or_equal_to: 0 }
end
