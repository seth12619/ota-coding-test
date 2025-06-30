class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total(pricing_rules = [])
    items = cart_items.includes(:product).to_a
    pricing_rules.each { |rule| rule.apply(items) }
    items.sum(&:total_price)
  end
end