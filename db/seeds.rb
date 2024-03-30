# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Rails.logger = Logger.new($stdout)

def seed_block(name)
  Rails.logger.info("Seeding #{name}")
  yield
  Rails.logger.info("#{name.capitalize} seeded")
end

seed_block 'AiQueryType' do
  ai_query_types = [
    'Quiz Generation',
    'Question Generation'
  ]

  ai_query_types.map do |name|
    AiQueryType.find_or_create_by!(name:)
  end
end
