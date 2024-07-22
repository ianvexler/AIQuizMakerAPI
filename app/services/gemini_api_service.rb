require 'singleton'

class GeminiApiService
  include Singleton

  def initialize
    api_key = ENV.fetch('GOOGLE_API_KEY').strip
    @client = GeminiApiClient.new(api_key)
  end

  def create_question(topic, difficulty)
    @client.create_question(topic, difficulty)
  end

  def validate_question(topic, difficulty, question_data)
    @client.validate_question(topic, difficulty, question_data)
  end
end
