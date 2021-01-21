FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    url  { Faker::Internet.url }
  end
end
