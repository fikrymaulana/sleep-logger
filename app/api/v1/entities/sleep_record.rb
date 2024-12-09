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
      format_duration(record.duration)
    end

    def format_duration(seconds)
      return "0 minutes" unless seconds.present? && seconds > 60
    
      hours = seconds / 3600
      minutes = (seconds % 3600) / 60
    
      if hours.positive? && minutes.positive?
        "#{hours} hours #{minutes} minutes"
      elsif hours.positive?
        "#{hours} hours"
      else
        "#{minutes} minutes"
      end
    end
  end
end
