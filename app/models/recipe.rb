class Recipe < ApplicationRecord
  serialize :detail, coder: JSON, type: Hash
  has_one_attached :photo

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :detail, presence: true

  has_many :user_recipes, dependent: :destroy
  has_many :users, through: :user_recipes
end
