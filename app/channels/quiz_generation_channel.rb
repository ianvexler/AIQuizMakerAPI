class QuizGenerationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quiz_generation_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup when channel is unsubscribed
  end

  def generate(data)
    topics = data['topics']
    difficulties = data['difficulties']
    quiz_type = data['type']
    length = data['length']

    quiz_generator = QuizGeneratorService.new(topics, difficulties, quiz_type, length, current_user)

    quiz = quiz_generator.generate_quiz

    if quiz.present? && quiz.save
      quiz.users << current_user
      ActionCable.server.broadcast("quiz_generation_#{current_user.id}", {
                                     status: 'completed',
        quiz_id: quiz.id
                                   })
    else
      ActionCable.server.broadcast("quiz_generation_#{current_user.id}", {
                                     status: 'error',
        message: 'There was an error generating the quiz'
                                   })
    end
  end
end
