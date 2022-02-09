FactoryBot.define do
  factory :rate do
    number_of_stars{rand(1..5)}
    association :user
    association :product
    association :comment
  end
end
