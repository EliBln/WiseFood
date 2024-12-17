require "openai"
require "open-uri"

class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @content = content()
    @recipes = []
    @recipes_text = @content.split(/},\s*{/)  # Sépare les recettes
    @recipes_text[0].sub!(/```json\s*\[\s*{/, "") # Nettoie le début
    @recipes_text[-1].sub!(/}\s*]\s*```/, "") # Nettoie la fin

    @recipes_text.each do |recipe_text|
      # Extraction des détails et transformation en hash
      details = recipe_text.match(/"détails":\s*"(.*?)"/m)[1]
      steps = details.split(/Étape \d+ : /).reject(&:empty?)
      details_hash = steps.each_with_index.map do |step, index|
        ["étape_#{index + 1}", step.strip]
      end.to_h

      @recipe = Recipe.create!(
        name: recipe_text.match(/"title":\s*"([^"]+)"/)[1].strip,
        ingredients: recipe_text.match(/"ingredients":\s*\[\s*((?:"[^"]+"\s*,?\s*)*)\]/m)[1]
          .scan(/"([^"]+)"/)
          .flatten
          .map(&:strip),
        detail: details_hash.transform_keys(&:to_sym),
      )
      set_photos(@recipe)
      @recipes << @recipe
    end
    @recipes
  end

  private

  def set_photos(recipe)
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
                                        prompt: "A recipe image of #{recipe[:name]}",
                                        size: "256x256",
                                      })

    url = response["data"][0]["url"]
    file = URI.parse(url).open

    recipe.photo.purge if recipe.photo.attached?
    recipe.photo.attach(
      io: file,
      filename: "ai_generated_image_#{recipe.id}.jpg",
      content_type: "image/png",
    )
  end

  def content
    @products = Product.where(user_id: current_user)
    @product_names = @products.pluck(:name).join(", ")
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
                                     model: "gpt-4o-mini",
                                     messages: [{ role: "user", content: "Donne moi deux recettes avec les différente étape dans détails avec les ingredients de mon frigo qui sont les suivants: #{@product_names}, ta reponse doit être au format JSON exactement comme ça: {\n      \"title\": \" \",\n      \"ingredients\": \n        \"\",\n        \"\",\n,\n      \"détails\": step 1\" \"\n    }, exemple de format: \n\n```json\n[\n  {\n    \"title\": \"Saumon au Camembert\",\n    \"ingredients\": [\n      \"150g de saumon\",\n      \"100g de camembert\",\n      \"Salade (au choix)\",\n      \"Lait (pour la sauce optional)\",\n      \"Sel\",\n      \"Poivre\"\n    ],\n    \"détails\": \"Étape 1 : Préchauffez votre four à 180°C. Étape 2 : Déposez le saumon dans un plat allant au four, assaisonnez avec du sel et du poivre. Étape 3 : Coupez le camembert en morceaux et disposez-les sur le saumon. Étape 4 : Si désiré, mélangez un peu de lait avec du sel et du poivre pour créer une sauce légère et versez-la sur le saumon. Étape 5 : Enfournez pendant 15-20 minutes jusqu'à ce que le saumon soit cuit. Étape 6 : Servez accompagné de la salade.\"\n  },\n  {\n    \"title\": \"Omelette au Poulet et Fromage\",\n    \"ingredients\": [\n      \"2 œufs\",\n      \"100g de poulet (cuit, si possible)\",\n      \"50g de camembert\",\n      \"Sel\",\n      \"Poivre\",\n      \"Beurre (pour la cuisson)\"\n    ],\n    \"détails\": \"Étape 1 : Dans un bol, cassez les œufs et battez-les avec du sel et du poivre. Étape 2 : Dans une poêle, faites fondre un peu de beurre à feu moyen. Étape 3 : Ajoutez le poulet coupé en morceaux et faites-le réchauffer légèrement. Étape 4 : Versez les œufs battus dans la poêle et laissez cuire pendant quelques minutes. Étape 5 : Ajoutez des morceaux de camembert sur une moitié de l'omelette. Étape 6 : Une fois que les œufs commencent à prendre, pliez l'omelette en deux et laissez cuire encore une minute. Étape 7 : Servez chaud.\"\n  }\n]\n```\n\nCes recettes sont simples et se préparent rapidement avec les ingrédients disponibles !" }],
                                   })

    @content = chatgpt_response["choices"][0]["message"]["content"]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :detail, :photo)
  end
end

# "Donne moi deux recettes avec les ingredients de mon frigo qui sont les suivants: #{@product_names}, ta reponse doit être au format JSON avec comme paramêtre: 'Title', 'Ingredients' et 'Detail'\n\n
# Recette 1", "content": "### Title: [Title]\n\n### Ingredients:\n- [Ingredients]\n\n### Détails:\n[Detail]\n\n
