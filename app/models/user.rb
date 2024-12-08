class User < ApplicationRecord
  # Soft delete
  acts_as_paranoid

  # Validations
  validates :name, presence: true, length: { maximum: 255 }

  # Follows relationships
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :follows
  has_many :inverse_follows, class_name: 'Follow', foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :inverse_follows, source: :follower
  
  has_many :sleep_records, dependent: :destroy
end
