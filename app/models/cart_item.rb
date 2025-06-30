class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  delegate :code, :name, :price, to: :product


  def total_price
    effective_quantity = instance_variable_defined?(:@effective_quantity) ? @effective_quantity : quantity
    discounted = instance_variable_defined?(:@discounted_price) ? @discounted_price : price
    discounted * effective_quantity
  end

  def as_json(options = {})
    super(options.merge(methods: [:code, :name, :price]))
  end
end