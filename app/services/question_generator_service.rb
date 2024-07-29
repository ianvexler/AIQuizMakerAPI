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
      @gemini_api_client = GeminiApiService.instance

      question_data = @gemini_api_client.validate_question(@topic, @difficulty, question_data)
      is_valid = question_data[:is_valid]
    end

    # Create question after validation
    question = Question.new(
      content: question_data['content'],
      confidence: question_data['confidence'],
      difficulty_id: @difficulty.id
    )

    question_data['options'].each do |option|
      question_option = QuestionOption.new(
        value: option['value'],
        is_correct: option['is_correct']
      )

      question.question_options << question_option
    end

    question.save
    question
  end
end
