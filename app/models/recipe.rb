class Recipe < ApplicationRecord
  serialize :detail, coder: JSON, type: Hash
  has_one_attached :photo

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :detail, presence: true

  has_many :user_recipes, dependent: :destroy
  has_many :users, through: :user_recipes


  # def set_photos
  #   client = OpenAI::Client.new
  #   response = client.images.generate(parameters: {
  #                                       prompt: "There is no people in the scene. Just a beautiful picture of a gourmet dish from above, of #{self.name} presented with elegance on a fine porcelain plate. The style is refined and minimalist, with a focus on vibrant warm colors and intricate details. The overall aesthetic is modern, gastronomic, and visually appetizing, as if featured in a high-end culinary magazine in a plate in the center of the picture. White backgroud.",
  #                                       size: "256x256"
  #                                     })

  #   url = response["data"][0]["url"]
  #   file = URI.parse(url).open

  #   self.photo.purge if self.photo.attached?
  #   self.photo.attach(
  #     io: file,
  #     filename: "ai_generated_image_#{self.id}.jpg",
  #     content_type: "image/png",
  #   )
  # end
end
