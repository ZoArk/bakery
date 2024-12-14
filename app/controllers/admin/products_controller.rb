class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  # app/controllers/admin/products_controller.rb
def create
  @product = Product.new(product_params)

  if @product.save
    flash[:notice] = "Product was successfully created."
    redirect_to admin_products_path
  else
    flash[:alert] = "There was an error creating the product."
    render :new
  end
end


  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

def product_params
  params.require(:product).permit(:name, :description, :price, :category_id, :stock_quantity, :image) # Ensure :image is permitted
end


  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end
