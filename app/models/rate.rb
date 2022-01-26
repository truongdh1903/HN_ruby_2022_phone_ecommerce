class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :comment
  validates :number_of_stars, numericality:
                              {less_than_or_equal_to: Settings.max_star_rate,
                               greater_than_or_equal_to: Settings.min_star_rate,
                               only_integer: true}
  scope :count_reviews_with_stars, (lambda do |product_id, number_of_stars|
    where(product_id: product_id, number_of_stars: number_of_stars)
  end)
end
