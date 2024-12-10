class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def new
      @product = Product.new
      @categories = Categorie.all
  end

  def show
  end

  def index
    @products = Product.includes(:categorie).all
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to @product, notice: 'Produit créé avec succès!'
    else
      render :new
    end
  end

    def update
       @product.update(product_params)
        redirect_to @product, notice: 'Produit mis à jour avec succès!'
    end

  def destroy
   if @product.destroy
    redirect_to products_path, notice: 'Produit supprimé avec succès!'
   else
    redirect_to products_path, alert: 'Erreur lors de la suppression du produit'
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

