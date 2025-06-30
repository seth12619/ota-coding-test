# app/controllers/api/carts_controller.rb

module Api
  class CartsController < ApplicationController
    def show
      cart = Cart.find(params[:id])
      items = cart.cart_items.includes(:product).to_a
      PricingRules.all.each { |rule| rule.apply(items) }
      total = items.sum do |item|
        effective_quantity = item.instance_variable_get(:@effective_quantity) || item.quantity
        discounted_price = item.instance_variable_get(:@discounted_price) || item.product.price
        (discounted_price * effective_quantity)
      end
      render json: {
        cart_id: cart.id,
        items: items.map { |item|
          {
            product: item.product.name,
            quantity: item.quantity,
            effective_quantity: item.instance_variable_get(:@effective_quantity) || item.quantity,
            price: item.product.price,
            discounted_price: item.instance_variable_get(:@discounted_price),
            total: ((item.instance_variable_get(:@discounted_price) || item.product.price) * (item.instance_variable_get(:@effective_quantity) || item.quantity)).round(2)
          }
        },
        total: total.round(2)
      }
    end

    def add_item
      cart = Cart.find(params[:id])
      product = Product.find(params[:product_id])
      item = cart.cart_items.find_or_initialize_by(product: product)
      item.quantity += params[:quantity].to_i
      item.save!
      render json: item
    end
  end
end
