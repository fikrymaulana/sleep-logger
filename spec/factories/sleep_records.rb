FactoryBot.define do
  factory :sleep_record do
    clock_in { 8.hours.ago }
    clock_out { Time.now }
    duration { 8.hours } 
    association :user
  end
end