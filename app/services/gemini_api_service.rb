require 'singleton'

class GeminiApiService
  include Singleton

  def initialize
    api_key = ENV.fetch('GOOGLE_API_KEY').strip
    @client = GeminiApiClient.new(api_key)
  end

  def create_question(topic, difficulty, other_questions)
    questions = other_questions.map(&:content)

    @client.create_question(topic, difficulty, questions)
  end

  def validate_question(topic, difficulty, question_data)
    @client.validate_question(topic, difficulty, question_data)
  end

  # Temporary for demo
  def create_quiz_from_file(topic, file, lenght)
    quiz_data = @client.create_quiz_from_file(topic, file, lenght)

    generate_quiz(quiz_data)
  end

  private

  # Temporary for demo
  def generate_question(question_data)
    question = Question.new(
      content: question_data['content'],
      confidence: question_data['confidence'],
      difficulty_id: Difficulty.all.sample.id
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

  # Temporary for demo
  def generate_quiz(quiz_data)
    topic = Topic.find_or_create_by(name: quiz_data['topic'], course_id: Course.find_by(name: 'Demo Course').id) do |t|
      t.archived = true
    end

    quiz = Quiz.new(
      length: quiz_data['length'].to_i,
      quiz_type: 'Demo Quiz'
    )

    quiz.difficulties << Difficulty.all
    quiz.topics << topic

    quiz_data['questions'].each do |question_data|
      question = generate_question(question_data)
      quiz.questions << question
    end

    quiz
  end
end
