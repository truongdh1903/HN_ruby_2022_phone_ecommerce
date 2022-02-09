FactoryBot.define do
  factory :comment do
    content {Faker::Marketing.buzzwords}
    association :user
    association :product
  end
end
