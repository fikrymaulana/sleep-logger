module V1::Entities
  class SleepRecord < Grape::Entity
    expose :id
    expose :clock_in do |record|
      record.clock_in.strftime('%b %d, %Y %I:%M %p')
    end
    expose :clock_out do |record|
      record.clock_out&.strftime('%b %d, %Y %I:%M %p')
    end
    expose :duration do |record|
      DurationHelper.format_duration(record.duration)
    end
  end
end
