class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def buy
    @cart = current_user.cart || Cart.find_by(session_id: session[:cart_id])

    if @cart.present?
      @cart_items = @cart.cart_items.includes(:product).select { |item| item.product.present? }
      @total = @cart_items.sum { |item| item.product.price * item.quantity }
    else
      @cart_items = []
      @total = 0
    end

    # Initialize @order if it's nil and ensure it's associated with the current user
    @order = current_user.orders.build if @order.nil?

    # Build an address if it doesn't already exist
    @order.build_address unless @order.address.present?
  end

  def payment
    # Assuming you have the logic to create an order here
    payment_successful = true

    # Process payment logic (e.g., integrating with a payment gateway)

    if payment_successful
      # Clear the session cart after successful payment
      session[:cart] = nil

      # Redirect to the thank you page after successful order placement
      redirect_to thankyou_checkout_index_path
    else
      render :buy
    end
  end

  def thank_you
    @order = current_user.orders.last # Assuming the most recent order is the one completed
  end

  private

  def calculate_total_amount_from_cart
    total_amount = 0

    session[:cart].each do |cart_item|
      product = Product.find(cart_item[0]) # cart_item[0] is the product_id
      total_amount += product.price * cart_item[1] # cart_item[1] is the quantity
    end

    total_amount
  end



  def order_params
    # Permit the total_amount field in case it's part of form submission
    params.require(:order).permit(:user_id, :total_amount, :status, :card_number, :expiry_date, :cvc)
  end

  def valid_card?(card_number, expiry_date, cvc)
    return false unless card_number =~ /^\d{16}$/
    return false unless expiry_date =~ %r{^(0[1-9]|1[0-2])/\d{2}$}
    return false unless cvc =~ /^\d{3}$/

    true
  end

  def address_params
    params.require(:address).permit(:street_address, :city, :province, :postal_code)
  end
end


