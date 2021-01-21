FactoryBot.define do
  factory :job do
    title      { Faker::Company.name }
    url        { Faker::Internet.url }
    event_date { Faker::Date.backward }
    association :organization
  end
end
