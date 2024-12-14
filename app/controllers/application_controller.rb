class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protected
  allow_browser versions: :modern

  # Custom method to initialize a cart
  def initialize_cart
    if current_user
      # If the user is logged in, associate the cart with their account
      @cart = current_user.cart || current_user.create_cart
    else
      # If the user is not logged in, use a session-based cart
      session[:cart_id] ||= Cart.create.id
      @cart = Cart.find(session[:cart_id])
    end
  end

  # Devise's after_sign_in_path_for method
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      root_path
    end
  end
end
