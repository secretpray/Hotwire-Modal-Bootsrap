class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    # @pagy, @products = pagy_countless(Product.recent)

    respond_to do |format|
      format.html { @pagy, @products = pagy_countless(Product.recent) }
      format.turbo_stream { @pagy, @products = pagy_countless(Product.recent) }
    end
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
        flash.now[:notice] = "Product '#{@product.name}' was successfully created!"
        format.turbo_stream
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
      else
        render_turbo_stream_error
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        flash.now[:notice] = "Product '#{@product.name}' was successfully updated."
        format.turbo_stream
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
      else
        render_turbo_stream_error
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    flash.now[:notice] = "Product '#{@product.name}' was successfully destroyed!"

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'Product was successfully destroyed.' }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end

  def render_turbo_stream_error
    flash.now[:alert] = @product.errors.full_messages.join('; ')
  end
end
