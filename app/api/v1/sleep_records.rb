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
          clock_out = Time.now
          duration = clock_out - record.clock_in
          record.update!(clock_out: clock_out, duration: duration)

          present record, with: V1::Entities::SleepRecord
        end
      end

      desc 'Get all sleep records'
      params do
        optional :page, type: Integer, default: 1
        optional :per_page, type: Integer, default: 20 
        optional :sort_order, type: String, default: 'desc'
      end
      get do
        records = current_user.sleep_records
                  .order(created_at: params[:sort_order])
                  .limit(params[:per_page])
                  .offset((params[:page] - 1) * params[:per_page])

        present records, with: V1::Entities::SleepRecord
      end

      desc 'Get sleep records of following users from the past week'
      params do
        optional :page, type: Integer, default: 1
        optional :per_page, type: Integer, default: 20 
        optional :sort_order, type: String, default: 'desc'
      end
      get :following do
        sleep_records = current_user.followees
                        .joins(:sleep_records)
                        .select('users.id AS user_id, 
                                 users.name AS user_name, 
                                 sleep_records.clock_in,
                                 sleep_records.clock_out,
                                 sleep_records.duration')
                        .where('sleep_records.clock_in >= ?', 1.week.ago)
                        .order(duration: params[:sort_order])
                        .limit(params[:per_page])
                        .offset((params[:page] - 1) * params[:per_page])

        present sleep_records, with: V1::Entities::FollowingSleepRecord
      end
    end
  end
end