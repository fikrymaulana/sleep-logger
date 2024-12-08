module V1
  class SleepRecords < Grape::API
    version 'v1', using: :path
    before { authenticate! }

    namespace :sleep_records do
      desc 'Clock in a sleep record'
      post do
        record = current_user.sleep_records.create!(clock_in: Time.now)
        { id: record.id, clock_in: record.clock_in }
      end
    end
  end
end