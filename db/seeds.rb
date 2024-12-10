# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# Clear existing data
puts "Cleaning database..."
Product.destroy_all
Categorie.destroy_all
User.destroy_all

puts "Creating seeds..."

# Create user first
user = User.create!(
  email: "user@user",
  password: "password",
)

# Create category second
categorie = Categorie.create!(
  name: "fromage",
)

# Create product with associations
product = Product.new(
  name: "camembert",
  expiration_date: "2023-12-09",
  quantity_stock: 1,
)
product.categorie = categorie
product.user = user

product.save!
puts "Finished! Created:"
puts "- #{User.count} user"
puts "- #{Categorie.count} category"
puts "- #{Product.count} product"
