FactoryBot.define do
  factory :category do
    name{Faker::Lorem.sentence(word_count: 3)}
    desc{Faker::Lorem.sentence(word_count: 30)}
  end
end
