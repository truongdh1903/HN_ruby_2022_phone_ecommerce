class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_color
  belongs_to :product_size
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image
end
