FactoryBot.define do
  factory :user do
    name{Faker::Name.name}
    desc{Faker::Lorem.sentence(word_count: 30)}
    email{Faker::Internet.email}
    address{Faker::Address.full_address}
    phone{rand(10_000_000...1_000_000_000)}
    password{"password"}
    password_confirmation{"password"}
    role{1}
  end
end
