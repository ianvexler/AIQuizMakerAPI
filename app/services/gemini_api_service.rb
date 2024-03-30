require 'singleton'

class GeminiApiService
  include Singleton

  def initialize
    api_key = ENV.fetch('GOOGLE_API_KEY').strip
    @client = GeminiApiClient.new(api_key)
  end

  def create_quiz(quiz_title)
    quiz_query = "Make a Quiz about #{quiz_title}"
    @client.create_quiz(quiz_query)
  end
end
