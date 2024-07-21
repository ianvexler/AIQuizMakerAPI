class QuestionGeneratorService
  def initialize(topic, difficulty)
    @topic = topic
    @difficulty = difficulty
  end

  def generate_question
    @gemini_api_client = GeminiApiService.instance
    
    question_data = @gemini_api_client.create_question(@topic, @difficulty)
    
    is_valid = false

    # Validate and repeat until validation passes
    while is_valid == false
      question_data = @gemini_api_client.validate_question(question_data)
      is_valid = question_data[:is_valid]
    end

    # Create question after validation
    Question.create(
      content: question_data[:content]
      confidence: question_data[:confidence]
      difficulty_id: @difficulty.id
    )
  end
end