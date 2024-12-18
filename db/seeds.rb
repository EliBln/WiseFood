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
crème = Categorie.create!(name: "Crème", img_url: "https://cdn-icons-png.flaticon.com/128/12754/12754961.png")
beurre = Categorie.create!(name: "Beurre", img_url: "https://cdn-icons-png.flaticon.com/128/4670/4670983.png")
condiment = Categorie.create!(name: "Condiment", img_url: "https://cdn-icons-png.flaticon.com/128/3106/3106132.png")

puts "Creating products..."
products_data = [
  { name: "Emmental", expiration_date: "2024-12-17", categorie: fromage, quantity_stock: 1 },
  { name: "Yaourt blanc", expiration_date: "2024-12-20", categorie: yaourt, quantity_stock: 1 },
  { name: "Poulet", expiration_date: "2024-12-19", categorie: volaille, quantity_stock: 1 },
  { name: "Steak de boeuf", expiration_date: "2024-12-25", categorie: viande, quantity_stock: 1 },
  { name: "Salade", expiration_date: "2024-12-20", categorie: légumes, quantity_stock: 1 },
  { name: "Lait", expiration_date: "2024-12-26", categorie: lait, quantity_stock: 2 },
  { name: "Banane", expiration_date: "2024-12-21", categorie: fruit, quantity_stock: 1 },
  { name: "Coca", expiration_date: "2025-12-18", categorie: boisson, quantity_stock: 1 },
  { name: "Oeuf", expiration_date: "2024-12-17", categorie: oeuf, quantity_stock: 1 },
  { name: "Bonbon", expiration_date: "2024-12-17", categorie: bonbon, quantity_stock: 1 },
  { name: "Basilic", expiration_date: "2024-12-25", categorie: légumes, quantity_stock: 1 },
  { name: "Tomate", expiration_date: "2024-12-22", categorie: légumes, quantity_stock: 1 },
  { name: "Crème fraîche", expiration_date: "2024-12-28", categorie: crème, quantity_stock: 1 },
  { name: "Beurre", expiration_date: "2025-1-12", categorie: beurre, quantity_stock: 1 },
  { name: "Mozzarella", expiration_date: "2024-12-20", categorie: fromage, quantity_stock: 1 },
  { name: "Moutarde", expiration_date: "2025-3-2", categorie: condiment, quantity_stock: 1 },
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
  ingredients: ["Pâtes", "crème", "oeufs", "oignons", "parmesan"],
)
carbonara.photo.attach(io: file, filename: "carbonara.jpg", content_type: "image/jpg")
carbonara.save!

file = URI.parse("https://via.placeholder.com/150").open
bolognese = Recipe.new(
  name: "Spaghetti Bolognaise",
  detail: {"étape_1"=> "Dans une grande casserole, faites chauffer un peu d'huile d'olive à feu moyen.",
    "étape_2"=>"Ajoutez un oignon émincé et faites-le revenir jusqu'à ce qu'il soit doré.",
    "étape_3"=>"Ajoutez de la viande hachée (boeuf ou mélange boeuf/porc) et faites cuire jusqu'à ce qu'elle soit bien dorée.",
    "étape_4"=>"Incorporez de la purée de tomates ou des tomates concassées, puis ajoutez un peu de sel, de poivre et des herbes de Provence.",
    "étape_5"=>"Laissez mijoter la sauce à feu doux pendant environ 20 minutes en remuant de temps en temps.",
    "étape_6"=>"Pendant ce temps, faites cuire les spaghetti dans une grande casserole d'eau bouillante salée, selon les instructions du paquet.",
    "étape_7"=>"Servez les spaghetti avec la sauce bolognaise chaude et un peu de parmesan râpé si désiré."},
  ingredients: ["Spaghetti", "viande hachée", "tomate", "oignons", "ail"],
)
bolognese.photo.attach(io: file, filename: "bolognese.jpg", content_type: "image/jpg")
bolognese.save!

file = URI.parse("https://via.placeholder.com/150").open
ratatouille = Recipe.new(
  name: "Ratatouille",
  detail: {"étape_1"=>"Dans une grande poêle ou une cocotte, faites chauffer un peu d'huile d'olive à feu moyen.",
    "étape_2"=>"Ajoutez un oignon émincé et faites-le revenir jusqu'à ce qu'il soit translucide.",
    "étape_3"=>"Ajoutez des courgettes, des aubergines et des poivrons coupés en dés, puis faites-les revenir pendant quelques minutes.",
    "étape_4"=>"Ajoutez des tomates concassées, de l'ail haché, du sel, du poivre et des herbes de Provence.",
    "étape_5"=>"Mélangez bien et laissez mijoter à feu doux pendant environ 30 à 40 minutes, en remuant de temps en temps.",
    "étape_6"=>"Si la ratatouille est trop liquide, laissez cuire encore quelques minutes pour réduire la sauce.",
    "étape_7"=>"Servez chaud, seul ou en accompagnement d'un plat de viande ou de riz."},
  ingredients: ["Tomates", "courgettes", "aubergines", "oignons", "poivrons"],
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
