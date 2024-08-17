class QuestionGeneratorService
  def initialize(topic, difficulty, user)
    @topic = topic
    @difficulty = difficulty
    @user = user
  end

  def generate_question(other_questions)
    # Assing existing question if any available
    if @user.present?
      available_questions = Question.unassigned_to_user(@user.id, @topic.id)

      # Remove already included questions
      available_questions = available_questions.reject do |question|
        other_questions.any? { |other_question| other_question.content == question.content }
      end

      if available_questions.any?
        return available_questions.sample
      end
    end

    @gemini_api_client = GeminiApiService.instance

    question_data = @gemini_api_client.create_question(@topic, @difficulty, other_questions)

    is_valid = false

    # Validate and repeat until validation passes
    while is_valid == false
      @gemini_api_client = GeminiApiService.instance

      question_data = @gemini_api_client.validate_question(@topic, @difficulty, question_data)
      is_valid = question_data[:is_valid]
    end

    build_question(question_data)
  end

  private

  def build_question(question_data)
    # Create question after validation
    question = Question.new(
      content: question_data['content'],
      confidence: question_data['confidence'],
      hints: question_data['hints'],
      difficulty_id: @difficulty.id,
      topic_id: @topic.id
    )

    question_data['options'].each do |option|
      question_option = QuestionOption.new(
        value: option['value'],
        is_correct: option['is_correct']
      )

      question.question_options << question_option
    end

    question
  end
end
