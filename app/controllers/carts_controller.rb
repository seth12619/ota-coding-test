class CartsController < ApplicationController
  before_action :set_cart

  def add_item
    @products = Product.all
    if request.post?
      product = Product.find(params[:product_id])
      quantity = params[:quantity].to_i
      item = @cart.cart_items.find_or_initialize_by(product: product)
      if item.new_record?
        item.quantity = quantity
      else
        item.quantity += quantity
      end
      item.save!
      flash[:notice] = "Added #{quantity} #{product.name}(s) to cart."
      redirect_to add_item_cart_path(@cart)
    end
    @items = @cart.cart_items.includes(:product).to_a
    PricingRules.all.each { |rule| rule.apply(@items) }
    @total = @items.sum(&:total_price)
  end

  def show
    @products = Product.all
    @items = @cart.cart_items.includes(:product).to_a
    PricingRules.all.each { |rule| rule.apply(@items) }
    @total = @items.sum(&:total_price)
  end

  private

  def set_cart
    @cart = Cart.find(params[:id]) || Cart.create!
  end
end
