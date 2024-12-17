require "open-uri"

# db/seeds.rb
puts "Cleaning database..."
Product.destroy_all
Categorie.destroy_all
UserRecipe.destroy_all
Recipe.destroy_all
User.destroy_all

puts "Creating user..."
user1 = User.create!(
  email: "user@user.com",
  password: "password"
)

puts "Creating categories..."
fromage = Categorie.create!(name: "Fromage", img_url: "https://cdn-icons-png.flaticon.com/128/1303/1303977.png")
viande = Categorie.create!(name: "Viande", img_url: "https://cdn-icons-png.flaticon.com/128/3143/3143643.png")
lait = Categorie.create!(name: "Lait", img_url: "https://cdn-icons-png.flaticon.com/128/869/869664.png")
légumes = Categorie.create!(name: "Légumes", img_url: "https://cdn-icons-png.flaticon.com/128/2153/2153786.png")
volaille = Categorie.create!(name: "Volaille", img_url: "https://cdn-icons-png.flaticon.com/128/3143/3143626.png")
bonbon = Categorie.create!(name: "Bonbon", img_url: "https://cdn-icons-png.flaticon.com/128/2575/2575864.png")
boisson = Categorie.create!(name: "Boisson", img_url: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png")
fruit = Categorie.create!(name: "Fruit", img_url: "https://cdn-icons-png.flaticon.com/128/1625/1625048.png")
oeuf = Categorie.create!(name: "Oeuf", img_url: "https://cdn-icons-png.flaticon.com/128/2713/2713474.png")
poisson = Categorie.create!(name: "Poisson", img_url: "https://cdn-icons-png.flaticon.com/128/2929/2929546.png")
yaourt = Categorie.create!(name: "Yaourt", img_url: "https://cdn-icons-png.flaticon.com/128/3142/3142859.png")

puts "Creating products..."
products_data = [
  { name: "Camembert", expiration_date: "2024-12-17", categorie: fromage, quantity_stock: 1 },
  { name: "Flan", expiration_date: "2024-12-20", categorie: yaourt, quantity_stock: 1 },
  { name: "Saumon", expiration_date: "2024-12-15", categorie: poisson, quantity_stock: 1 },
  { name: "Poulet", expiration_date: "2024-12-19", categorie: volaille, quantity_stock: 1 },
  { name: "Steak", expiration_date: "2024-12-25", categorie: viande, quantity_stock: 1 },
  { name: "Salade", expiration_date: "2024-12-20", categorie: légumes, quantity_stock: 1 },
  { name: "Lait", expiration_date: "2024-12-26", categorie: lait, quantity_stock: 2 },
  { name: "Banane", expiration_date: "2024-12-21", categorie: fruit, quantity_stock: 1 },
  { name: "Coca", expiration_date: "2025-12-18", categorie: boisson, quantity_stock: 1 },
  { name: "Oeuf", expiration_date: "2024-12-17", categorie: oeuf, quantity_stock: 1 },
  { name: "Bonbon", expiration_date: "2024-12-17", categorie: bonbon, quantity_stock: 1 }
]

products_data.each do |product_data|
  Product.create!(
    name: product_data[:name],
    expiration_date: product_data[:expiration_date],
    categorie: product_data[:categorie],
    quantity_stock: product_data[:quantity_stock],
    user_id: user1.id
  )
end

puts "Creating recipes..."
file = URI.parse("https://via.placeholder.com/150").open
carbonara = Recipe.new(
  name: "Pâtes Carbonara",
  detail: {"étape_1"=>"Dans un bol, cassez les œufs et battez-les avec du sel et du poivre.",
  "étape_2"=>"Dans une poêle, faites fondre un peu de beurre à feu moyen.",
  "étape_3"=>"Ajoutez le poulet coupé en morceaux et faites-le réchauffer légèrement.",
  "étape_4"=>"Versez les œufs battus dans la poêle et laissez cuire pendant quelques minutes.",
  "étape_5"=>"Ajoutez des morceaux de camembert sur une moitié de l'omelette.",
  "étape_6"=>"Une fois que les œufs commencent à prendre, pliez l'omelette en deux et laissez cuire encore une minute.",
  "étape_7"=>"Servez chaud."},
  ingredients: "Pâtes, crème, oeufs, oignons, parmesan"
)
carbonara.photo.attach(io: file, filename: "carbonara.jpg", content_type: "image/jpg")
carbonara.save!

file = URI.parse("https://via.placeholder.com/150").open
bolognese = Recipe.new(
  name: "Spaghetti Bolognaise",
  detail: {"étape_1"=>"Dans un bol, cassez les œufs et battez-les avec du sel et du poivre.",
  "étape_2"=>"Dans une poêle, faites fondre un peu de beurre à feu moyen.",
  "étape_3"=>"Ajoutez le poulet coupé en morceaux et faites-le réchauffer légèrement.",
  "étape_4"=>"Versez les œufs battus dans la poêle et laissez cuire pendant quelques minutes.",
  "étape_5"=>"Ajoutez des morceaux de camembert sur une moitié de l'omelette.",
  "étape_6"=>"Une fois que les œufs commencent à prendre, pliez l'omelette en deux et laissez cuire encore une minute.",
  "étape_7"=>"Servez chaud."},
  ingredients: "Spaghetti, viande hachée, tomate, oignons, ail"
)
bolognese.photo.attach(io: file, filename: "bolognese.jpg", content_type: "image/jpg")
bolognese.save!

file = URI.parse("https://via.placeholder.com/150").open
ratatouille = Recipe.new(
  name: "Ratatouille",
  detail: {"étape_1"=>"Dans un bol, cassez les œufs et battez-les avec du sel et du poivre.",
  "étape_2"=>"Dans une poêle, faites fondre un peu de beurre à feu moyen.",
  "étape_3"=>"Ajoutez le poulet coupé en morceaux et faites-le réchauffer légèrement.",
  "étape_4"=>"Versez les œufs battus dans la poêle et laissez cuire pendant quelques minutes.",
  "étape_5"=>"Ajoutez des morceaux de camembert sur une moitié de l'omelette.",
  "étape_6"=>"Une fois que les œufs commencent à prendre, pliez l'omelette en deux et laissez cuire encore une minute.",
  "étape_7"=>"Servez chaud."},
  ingredients: "Tomates, courgettes, aubergines, oignons, poivrons"
)
ratatouille.photo.attach(io: file, filename: "ratatouille.jpg", content_type: "image/jpg")
ratatouille.save!

puts "Adding recipes to favorites..."
UserRecipe.create!(user: user1, recipe: carbonara)
UserRecipe.create!(user: user1, recipe: bolognese)
UserRecipe.create!(user: user1, recipe: ratatouille)

puts "Finished! Created:"
puts "- #{User.count} users"
puts "- #{Categorie.count} categories"
puts "- #{Product.count} products"
puts "- #{Recipe.count} recipes"
puts "- #{UserRecipe.count} user recipes"
