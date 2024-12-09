# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# Generate test data for development
# Execute only in development environment
if Rails.env.development?
  # Generate random users
  5.times do
    User.create(
      name: Faker::Name.name,
      created_at: Time.now,
      updated_at: Time.now,
      api_key: SecureRandom.hex(20)
    )
  end
end
