class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    # Check if session[:cart] exists and is a hash
    if session[:cart].present? && session[:cart].is_a?(Hash)
      @cart_items = session[:cart].map do |product_id, quantity|
        product = Product.find_by(id: product_id)

        # Ensure the product exists before mapping
        if product
          { product: product, quantity: quantity }
        else
          nil
        end
      end.compact  # Remove nil entries (in case a product is not found)

      # If the cart is empty or invalid, redirect the user
      if @cart_items.empty?
        redirect_to cart_path, notice: "Your cart is empty. Please add items before proceeding."
      end
    else
      @cart_items = []
    end
  end
end
