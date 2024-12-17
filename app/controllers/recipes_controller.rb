require "openai"
require "open-uri"

class RecipesController < ApplicationController

  def show
    # @recipe = Recipe.find(params[:id])
  end

  def new
    @content = content()
    @recipes = []
    @recipes_text = @content.split(/(?="title")/)
    @recipes_text.shift  # Enlève l'introduction

    @recipes_text.each do |recipe_text|
      @recipe = Recipe.create!(
        name: recipe_text.match(/"title":\s*"([^"]+)"/)[1].strip,
        ingredients: recipe_text
          .match(/"ingredients":\s*\[(.*?)\]/m)[1]
          .scan(/"([^"]+)"/)
          .flatten,
        detail: recipe_text
          .match(/"détails":\s*"([^"]+)"/)[1]
          .strip,
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
                                     messages: [{ role: "user", content: "Donne moi deux recettes avec les ingredients de mon frigo qui sont les suivants: #{@product_names}, ta reponse doit être au format JSON exactement comme ça: {\n      \"title\": \" \",\n      \"ingredients\": [\n        \"\",\n        \"\",\n],\n      \"détails\": \" \"\n    }"}],
                                   })

    @content = chatgpt_response["choices"][0]["message"]["content"]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :detail, :photo)

  end
end

# "Donne moi deux recettes avec les ingredients de mon frigo qui sont les suivants: #{@product_names}, ta reponse doit être au format JSON avec comme paramêtre: 'Title', 'Ingredients' et 'Detail'\n\n
# Recette 1", "content": "### Title: [Title]\n\n### Ingredients:\n- [Ingredients]\n\n### Détails:\n[Detail]\n\n
