class SleepRecord < ApplicationRecord
  # Soft delete
  acts_as_paranoid

  # Associations
  belongs_to :user

end
