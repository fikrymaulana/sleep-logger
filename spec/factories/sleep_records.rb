FactoryBot.define do
  factory :sleep_record do
    clock_in { Time.now }
    clock_out { nil }
    association :user
  end
end