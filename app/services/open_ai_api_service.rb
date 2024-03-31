require 'singleton'

class OpenAiApiService
  include Singleton

  def initialize
    api_key = ENV.fetch('OPEN_AI_API_KEY').strip
    @client = OpenAiApiClient.new(api_key)
  end

  def create_quiz(title, goal, instructions)
    @client.create_quiz(title, goal, instructions)
  end

  def test_query(text, json_format)
    @client.test_query(text, json_format)
  end
end
