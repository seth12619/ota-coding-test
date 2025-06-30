# app/services/pricing_rules.rb

module PricingRules
  def self.all
    [
      BuyOneGetOneFreeRule.new('green tea'),
      BulkDiscountRule.new('strawberries', 3, 4.50),
      CoffeeDiscountRule.new('coffee', 3, 2.0/3.0)
    ]
  end

  class BuyOneGetOneFreeRule
    def initialize(product_name)
      @product_name = product_name
    end

    def apply(items)
      item = items.find { |i| i.product.name.downcase == @product_name }
      return unless item && item.quantity > 1
      free = item.quantity / 2
      item.instance_variable_set(:@effective_quantity, item.quantity - free)
    end
  end

  class BulkDiscountRule
    def initialize(product_name, min_qty, new_price)
      @product_name, @min_qty, @new_price = product_name, min_qty, new_price
    end

    def apply(items)
      item = items.find { |i| i.product.name.downcase == @product_name }
      return unless item && item.quantity >= @min_qty
      item.instance_variable_set(:@discounted_price, @new_price)
    end
  end

  class CoffeeDiscountRule
    def initialize(product_name, min_qty, fraction)
      @product_name, @min_qty, @fraction = product_name, min_qty, fraction
    end

    def apply(items)
      item = items.find { |i| i.product.name.downcase == @product_name }
      return unless item && item.quantity >= @min_qty
      discounted = (item.product.price * @fraction).round(2)
      item.instance_variable_set(:@discounted_price, discounted)
    end
  end
end
