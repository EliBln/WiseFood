class User < ApplicationRecord
  has_many :products
  has_many :user_recipes, dependent: :destroy
  has_many :recipes, through: :user_recipes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
