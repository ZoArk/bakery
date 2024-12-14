
class ProductsController < ApplicationController
  def index
    @cart = session[:cart] || {}
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id]).page(params[:page]).per(15)
    elsif params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%").page(params[:page]).per(15)
    else
      @products = Product.all.page(params[:page]).per(15)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

end
