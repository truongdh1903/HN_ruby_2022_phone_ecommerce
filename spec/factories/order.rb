FactoryBot.define do
  factory :order do
    delivery_address{Faker::Address.full_address}
    delivery_phone{"#{rand(100_000_000...1_000_000_000)}"}
    shiped_date{Faker::Date.between(from: "2014-09-23", to: "2021-09-25")}
    association :user,
    status{:pending},
    customer_name{Faker::Name.name},
    note{Faker::Lorem.sentence(word_count: 5)}
  end
end
