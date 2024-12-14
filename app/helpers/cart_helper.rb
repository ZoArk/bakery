module CartHelper
  def calculate_cart_total
    return 0 if session[:cart].nil?

    session[:cart].sum do |product_id, quantity|
      product = Product.find(product_id)
      product.price * quantity
    end
  end

end
