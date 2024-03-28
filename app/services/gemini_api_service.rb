require 'singleton'

class GeminiApiService
  include 'Singleton'

  def initialize
    api_key = ENV.fetch('GEMINI_API_KEY').strip
    @client = GeminiApiClient.new(api_key)
  end

  def create_quiz
    @client.create_quiz
  end
end