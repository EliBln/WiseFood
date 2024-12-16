require "openfoodfacts"

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def reorder
    Rails.logger.info "Reorder params received: #{params.inspect}"
    
    if params[:order].blank?
      Rails.logger.error "No order parameter received"
      return render json: { error: "No order parameter received" }, status: :bad_request
    end

    begin
      ActiveRecord::Base.transaction do
        params[:order].each_with_index do |id, index|
          Rails.logger.info "Updating product #{id} to position #{index + 1}"
          Product.where(id: id).update_all(position: index + 1)
        end
      end
      
      Rails.logger.info "Reorder successful"
      render json: { success: true }
    rescue => e
      Rails.logger.error "Error during reorder: #{e.message}"
      render json: { error: e.message }, status: :internal_server_error
    end
  end

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
    @products = Product.includes(:categorie).order(:position)
    @shelves = @products.each_slice(3).to_a
    @categories = Categorie.all
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
      @categories = Categorie.all  # Ajouter cette ligne pour réafficher le formulaire en cas d'erreur
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
