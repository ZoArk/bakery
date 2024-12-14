class CartController < ApplicationController
  before_action :initialize_cart
  before_action :authenticate_user!, only: [:add_to_cart]  # Allow guest users to view cart or add to cart

  def show
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      # For guest users, fall back to session-based cart
      @cart = Cart.find_by(session_id: session[:cart_id])
    end
    # Initialize cart_items for both user and guest carts
    @cart_items = @cart&.cart_items || []
  end


  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user
      # Handle the user's cart (authenticated users)
      @cart = current_user.cart || current_user.create_cart

      # Add the product to the user's cart
      existing_item = @cart.cart_items.find_by(product: product)
      if existing_item
        existing_item.increment!(:quantity)
      else
        @cart.cart_items.create(product: product, quantity: 1)
      end

      # Redirect to the user's cart
      redirect_to cart_path(@cart) # Pass the cart ID for user carts
    end
  end



  def destroy
    if current_user
      current_user.cart.destroy if current_user.cart.present?
    else
      session[:cart_id] = nil  # Clear the session-based cart when logging out
    end
    reset_session  # Reset all session data
    redirect_to root_path
  end

  def update_quantity
    cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity <= 0
      cart_item.destroy
      flash[:notice] = "Item removed from cart."
    else
      cart_item.update(quantity: new_quantity)
      flash[:notice] = "Quantity updated."
    end

    redirect_to cart_path(@cart)
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    flash[:notice] = "Item removed from cart."
    redirect_to cart_path(@cart)
  end



  private
def initialize_cart
  if current_user
    @cart = current_user.cart || current_user.create_cart
  else
    session[:cart_id] ||= SecureRandom.uuid
    @cart = Cart.find_or_create_by(session_id: session[:cart_id])
  end
end



  def current_cart
    @cart ||= Cart.find_by(session_id: session[:cart_id])  # For guest users
    @cart ||= current_user.cart if current_user  # For logged-in users
  end
end
