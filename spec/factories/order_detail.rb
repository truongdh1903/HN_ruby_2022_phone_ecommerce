FactoryBot.define do
  factory :order_detail do
    quantity{rand(10)}
    cost_product{rand(20_000_000)}
    association :order
    association :product_detail
  end
end
