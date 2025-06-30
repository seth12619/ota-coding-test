class Product < ApplicationRecord
  validates :code, :name, :price, presence: true
  validates :code, uniqueness: true
end