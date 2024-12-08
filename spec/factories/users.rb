FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    api_key { SecureRandom.hex(20) }
  end
end
