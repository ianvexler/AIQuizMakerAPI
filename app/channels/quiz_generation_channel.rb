class QuizGenerationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quiz_generation_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup when the channel is unsubscribed
  end

  def generate(data)
    quiz = generate_quiz(data)
    broadcast_quiz_result(quiz)
  end

  private

  # Method for generating the quiz
  def generate_quiz(data)
    topics = data['topics']
    difficulties = data['difficulties']
    quiz_type = data['type']
    length = data['length']

    begin
      quiz_generator = QuizGeneratorService.new(topics, difficulties, quiz_type, length, current_user)
      quiz = quiz_generator.generate_quiz

      if quiz.present? && quiz.save
        quiz.users << current_user
        quiz
      end
    rescue StandardError => e
      Rails.logger.error "Quiz generation failed: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      disconnect

      nil
    end
  end

  # Method for broadcasting the result
  def broadcast_quiz_result(quiz)
    if quiz
      ActionCable.server.broadcast("quiz_generation_#{current_user.id}", {
                                     status: 'completed',
                                     quiz_id: quiz.id
                                   })
    else
      disconnect
    end
  end

  def disconnect
    transmit({
               type: 'error',
      error: 'There was an error generating the quiz',
      reconnect: false
             })

    stop_all_streams
    connection.close
  end
end
