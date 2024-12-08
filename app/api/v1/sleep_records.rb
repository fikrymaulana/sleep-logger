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

      desc 'Clock out a sleep record'
      params do
        optional :sleep_record_id, type: Integer
      end
      put :clock_out do
        # TODO: Do we need to check whether the previous clock in time is more than 24 hours?
        record = current_user.sleep_records
                  .where(clock_out: nil)
        
        record = record.where(id: params[:sleep_record_id]) if params[:sleep_record_id].present?
        
        record = record.order(:created_at).last

        if record.nil?
          error!('No active sleep record found to clock out', 404)
        else
          record.update!(clock_out: Time.now)

          { id: record.id, clock_in: record.clock_in, clock_out: record.clock_out }
        end
      end
    end
  end
end