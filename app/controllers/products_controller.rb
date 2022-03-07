class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.recent
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        redirect_to products_path, notice: "Product was successfully created."
      else
        render :form_update, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        redirect_to products_path, notice: "Product was successfully updated."
      else
        render :form_update, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      redirect_to products_path, notice: "Product was successfully destroyed."
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description)
    end
end
