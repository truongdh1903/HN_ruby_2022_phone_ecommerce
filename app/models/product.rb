class Product < ApplicationRecord
  belongs_to :category
  has_many :product_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :likes, dependent: :destroy
end
