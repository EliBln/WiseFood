require "openfoodfacts"

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  
  # def scan
  #   scanned_product = Product.find(params[:id]) # Trouver le produit scanné par son ID
  #   @products = Product.all.to_a # Charger tous les produits dans un tableau
  #   @products.unshift(scanned_product) # Ajouter le produit scanné au début
  # end

  def new
    @product = Product.new
    @categories = Categorie.all
    @barcode = params[:barcode]

    if @barcode.present?
      @foodfactproduct = Openfoodfacts::Product.get(@barcode, locale: "fr")
      @name = @foodfactproduct&.product_name&.truncate(18, omission: "...")
      @categorie = @foodfactproduct&.categories

      if @foodfactproduct&.categories
        @food_categories = @foodfactproduct.categories.downcase.split(",")
        @matched_category = Categorie.all.find do |cat|
          @food_categories.any? { |food_cat| food_cat.include?(cat.name.downcase) }
        end
      end
    end
  end

  def show
    @categorie = @product.categorie
    @days_remaining = @product.days_remaining
  end

  def index
    def index
      # Start with current user's products
      @products = Product.where(user_id: current_user.id)
        .includes(:categorie) || [] # Eager load categories

      # Apply category filter if present
      if params[:category].present?
        @products = @products.where(categorie_id: params[:category])
      end

      # Apply sorting
      # if params[:sort].present?
        @products = case params[:sort]
          when "name"
            @products.order(:name)
          when "expiration"
            @products.order(:expiration_date)
          else
            @products.order(:expiration_date) # Default sorting
          end
      # end
      @products = @products.to_a || []
      # Group products for shelf display
      @shelves = @products.each_slice(3).to_a

      # Get categories for filter menu
      @categories = Categorie.all
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user


    if @product.save
      redirect_to products_path, notice: "Produit créé avec succès!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Categorie.all  # Ajouter cette ligne pour avoir accès aux catégories dans le formulaire

    # unless @product.user == current_user
    #   redirect_to products_path, alert: "Vous n'êtes pas autorisé à modifier ce produit"
    #   return
    # end
  end

  def update

    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Produit mis à jour avec succès!"
    else
      @categories = Categorie.all  # Réafficher le formulaire en cas d'erreur
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Produit supprimé avec succès!"
    else
      redirect_to products_path, alert: "Erreur lors de la suppression du produit"
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :expiration_date, :categorie_id, :quantity_stock, :user_id)
  end
end
