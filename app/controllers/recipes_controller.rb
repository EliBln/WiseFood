require "openai"
require "open-uri"

class RecipesController < ApplicationController

  def show
    # @recipe = Recipe.find(params[:id])

  def new
    @content = content()
    @recipe = Recipe.create!(
      name: @content.match(/### Title\n(.*?)\n/)[1],
      ingredients: @content
        .match(/### Ingredients\n((?:- .*\n)+)/)[1]
        .split("\n")
        .map { |i| i.gsub(/^- /, "").strip }
        .reject(&:empty?),
      detail: @content
        .match(/### Détails\n(.*?)(?=\n\n$|\z)/m)[1]
        .scan(/\d+\.\s+\*\*(.*?)\*\*\s*:(.*?)(?=\n\n\d+\.|$)/m)
        .map.with_index(1) do |(title, description), index|
        {
          step: index,
          title: title.strip,
          description: description.strip,
        }
      end,
    )
    set_photo(@recipe)
  end

  private

  def set_photo(recipe)
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
                                        prompt: "A recipe image of #{recipe[:name]}", size: "256x256",
                                      })

    url = response["data"][0]["url"]
    file = URI.parse(url).open

    recipe.photo.purge if recipe.photo.attached?
    recipe.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
  end

  def content
    @products = Product.where(user_id: 10)
    @product_names = @products.pluck(:name).join(", ")
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
                                     model: "gpt-4o-mini",
                                     messages: [{ role: "user", content: "Donne moi une recette avec les ingredients de mon frigo qui sont les suivants: #{@product_names}, list la recette avec les clés : ### Title, ### Ingredients, ### Détails" }],
                                   })
    @content = chatgpt_response["choices"][0]["message"]["content"]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :detail, :photo)

  end
end
