class Follow < ApplicationRecord
  # Soft delete
  acts_as_paranoid

  # Associations
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
end
