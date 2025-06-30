require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.create! }
  let(:green_tea) { Product.create!(code: 'GR1', name: 'green tea', price: 3.11) }
  let(:strawberries) { Product.create!(code: 'SR1', name: 'strawberries', price: 5.00) }
  let(:coffee) { Product.create!(code: 'CF1', name: 'coffee', price: 11.23) }

  before do
    cart.cart_items.create!(product: green_tea, quantity: 2)
    cart.cart_items.create!(product: strawberries, quantity: 1)
    cart.cart_items.create!(product: coffee, quantity: 1)
  end

  it 'calculates total without pricing rules' do
    expect(cart.total).to eq(3.11*2 + 5.00 + 11.23)
  end

  it 'applies pricing rules for green tea (BOGOF)' do
    rules = [PricingRules::BuyOneGetOneFreeRule.new('green tea')]
    expect(cart.total(rules)).to eq(3.11*1 + 5.00 + 11.23)
  end

  it 'applies bulk discount for strawberries' do
    cart.cart_items.find_by(product: strawberries).update!(quantity: 3)
    rules = [PricingRules::BulkDiscountRule.new('strawberries', 3, 4.50)]
    expect(cart.total(rules)).to eq(3.11*2 + 4.50*3 + 11.23)
  end

  it 'applies coffee discount for 3 or more coffees' do
    cart.cart_items.find_by(product: coffee).update!(quantity: 3)
    rules = [PricingRules::CoffeeDiscountRule.new('coffee', 3, 2.0/3.0)]
    discounted = (11.23 * 2.0/3.0).round(2)
    expect(cart.total(rules)).to eq(3.11*2 + 5.00 + discounted*3)
  end

  it 'applies all pricing rules together' do
    cart.cart_items.find_by(product: strawberries).update!(quantity: 3)
    cart.cart_items.find_by(product: coffee).update!(quantity: 3)
    rules = PricingRules.all
    discounted_coffee = (11.23 * 2.0/3.0).round(2)
    expect(cart.total(rules)).to eq(3.11*1 + 4.50*3 + discounted_coffee*3)
  end
end
