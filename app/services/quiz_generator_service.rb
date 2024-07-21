class QuizGeneratorService
  def initialize(topics, difficulties, type)
    @topics = topics.shuffle
    @difficulties = difficulties
    @type = type
  end

  def generate_quiz(length)
    return nil if length <= 0

    @quiz = Quiz.new(
      length: length,
      topics: @topics,
      difficulties: @difficulties,
      type: @type
    )

    questions_per_topic = length / @topics.count
    extra_questions = length % @topics.count

    generate_questions(questions_per_topic)
    distribute_remaining_questions(extra_questions)

    @quiz.save
    @quiz
  end

  private

  def generate_questions(questions_per_topic)
    @topics.each do |topic|
      questions_per_topic.times do
        question_generator = QuestionGeneratorService.instance(topic, @difficulties.sample)
        question = question_generator.generate_question
        @quiz.questions << question
      end
    end
  end

  def distribute_remaining_questions(remaining_questions)
    remaining_questions.times do
      question_generator = QuestionGeneratorService.instance(@topics.sample, @difficulties.sample)
      question = question_generator.generate_question
      @quiz.questions << question
    end
  end
end
