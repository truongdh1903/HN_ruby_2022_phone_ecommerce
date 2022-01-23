class Product < ApplicationRecord
  belongs_to :category
  has_many :product_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :filter_by_product_size_id, (lambda do |product_size_id|
    joins(:product_details)
      .where(product_details: {product_size_id: product_size_id})
  end)
  scope :filter_by_product_color_id, (lambda do |product_color_id|
    joins(:product_details)
      .where(product_details: {product_color_id: product_color_id})
  end)
  scope :filter_by_max_cost, (lambda do |max_cost|
    joins(:product_details)
      .group("product_id")
      .having("avg(product_details.cost) < ?", max_cost)
  end)
  scope :filter_by_min_cost, (lambda do |min_cost|
    joins(:product_details)
      .group("products.id")
      .having("avg(product_details.cost) > ?", min_cost)
  end)
  scope :search, ->(key){where("LOWER(name) like ?", "%#{key.downcase}%")}
  scope :order_created_at, ->{order(created_at: :desc)}
end
