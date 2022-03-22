class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_pagination, only: %i[ index create destroy ]

  def index
    logger_pagy
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
        flash.now[:notice] = notice('created')
        format.turbo_stream
        format.html { redirect_to products_path, notice: notice('created') }
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
        flash.now[:notice] = notice('updated')
        format.turbo_stream
        format.html { redirect_to products_path, notice: notice('updated') }
      else
        render_turbo_stream_error
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    flash.now[:notice] = notice('destroyed')

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: notice('destroyed') }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_pagination
    @pagy, @products = pagy_countless(Product.recent)    
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end

  def render_turbo_stream_error
    flash.now[:alert] = @product.errors.full_messages.join('; ')
  end

  def notice(action)
    "Product '#{@product.name}' was successfully #{action}!"
  end

  def logger_pagy
    logger.tagged("Pagination [pagy object]") { logger.debug "@pagy: #{@pagy.inspect}" }
    logger.tagged("Pagination [list id]") { logger.info "@products: #{@products.pluck(:id) }" }
  end
end
