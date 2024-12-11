# db/seeds.rb
puts "Cleaning database..."
Product.destroy_all
Categorie.destroy_all
User.destroy_all

puts "Creating user..."
user1 = User.create!(
  email: "user@user.com",
  password: "password"
)

puts "Creating categories..."
fromage = Categorie.create!(
  name: "Fromage",
  img_url: "https://cdn-icons-png.flaticon.com/128/1303/1303977.png"
)

viande = Categorie.create!(
  name: "Viande",
  img_url: "https://cdn-icons-png.flaticon.com/128/3143/3143643.png"
)

lait = Categorie.create!(
  name: "Lait",
  img_url: "https://cdn-icons-png.flaticon.com/128/869/869664.png"
)

légumes = Categorie.create!(
  name: "Légumes",
  img_url: "https://cdn-icons-png.flaticon.com/128/2153/2153786.png"
)

volaille = Categorie.create!(
  name: "Volaille",
  img_url: "https://cdn-icons-png.flaticon.com/128/3143/3143626.png"
)

puts "Creating products..."
products_data = [
  { name: "Camembert", expiration_date: "2024-12-17", categorie: fromage, quantity_stock: 1 },
  { name: "Comté", expiration_date: "2024-12-16", categorie: fromage, quantity_stock: 1 },
  { name: "Chèvre", expiration_date: "2024-12-15", categorie: fromage, quantity_stock: 1 },
  { name: "Poulet", expiration_date: "2024-12-19", categorie: volaille, quantity_stock: 1 },
  { name: "Steak", expiration_date: "2024-12-25", categorie: viande, quantity_stock: 1 },
  { name: "Salade", expiration_date: "2024-12-20", categorie: légumes, quantity_stock: 1 },
  { name: "Lait", expiration_date: "2025-12-15", categorie: lait, quantity_stock: 2 },
]

products_data.each do |product_data|
  Product.create!(
    name: product_data[:name],
    expiration_date: product_data[:expiration_date],
    categorie: product_data[:categorie],
    quantity_stock: product_data[:quantity_stock],
    user: user1
  )
end

puts "Finished! Created:"
puts "- #{User.count} users"
puts "- #{Categorie.count} categories"
puts "- #{Product.count} products"
