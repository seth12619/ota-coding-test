# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.find_or_create_by!(code: 'GR1') do |p|
  p.name = 'green tea'
  p.price = 3.11
end
Product.find_or_create_by!(code: 'SR1') do |p|
  p.name = 'strawberries'
  p.price = 5.00
end
Product.find_or_create_by!(code: 'CF1') do |p|
  p.name = 'coffee'
  p.price = 11.23
end
