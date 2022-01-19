class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_color
  belongs_to :product_size
  has_many :order_details, dependent: :destroy
end
