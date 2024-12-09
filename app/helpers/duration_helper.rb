module DurationHelper
  def self.format_duration(seconds)
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
