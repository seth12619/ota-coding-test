require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { Cart.create! }
  let(:product) { Product.create!(code: 'GR1', name: 'green tea', price: 3.11) }

  subject { described_class.new(cart: cart, product: product, quantity: 2) }

  it 'delegates code, name, and price to product' do
    expect(subject.code).to eq('GR1')
    expect(subject.name).to eq('green tea')
    expect(subject.price).to eq(3.11)
  end

  it 'calculates total_price with default price' do
    expect(subject.total_price).to eq(6.22)
  end

  it 'calculates total_price with discounted_price' do
    subject.instance_variable_set(:@discounted_price, 2.00)
    expect(subject.total_price).to eq(4.00)
  end

  it 'includes code, name, and price in as_json' do
    json = subject.as_json
    expect(json['code']).to eq('GR1')
    expect(json['name']).to eq('green tea')
    expect(json['price'].to_f).to eq(3.11)
  end
end
