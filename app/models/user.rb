class User < ApplicationRecord
  # Soft delete
  acts_as_paranoid

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  
end
