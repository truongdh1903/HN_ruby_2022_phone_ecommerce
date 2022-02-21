FactoryBot.define do
  factory :order do
    delivery_address{Faker::Address.full_address}
    delivery_phone{rand(10_000_000...1_000_000_000)}
    status{0}
    shiped_date{Faker::Date.between(from: "2014-09-23", to: "2021-09-25")}
    association :user
  end
end
