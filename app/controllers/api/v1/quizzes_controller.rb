class Api::V1::QuizzesController < Api::V1::BaseController
  rescue_from Faraday::BadRequestError, with: :handle_bad_request

  def create
    quiz_generator = QuizGeneratorService.new(
      quiz_params[:topics],
      quiz_params[:difficulties],
      quiz_params[:type],
      quiz_params[:length]
    )

    @quiz = quiz_generator.generate_quiz
    @quiz.users << current_user

    return render json: @quiz, serializer: QuizSerializer, status: :ok if @quiz.present? && @quiz.save

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  def create_from_file
    @gemini_api_service = GeminiApiService.instance

    @quiz = @gemini_api_service.create_quiz_from_file(params[:topic], params[:file], params[:length])

    return render json: @quiz, serializer: QuizSerializer, status: :ok if @quiz.present? && @quiz.save

    Rails.logger.debug @quiz.errors.to_json

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  private

  def quiz_params
    params.require(:quiz).permit(:type, :length, topics: [], difficulties: [])
  end

  def handle_bad_request(exception)
    response = {
      message: exception.message,
      body: exception.response[:body]
    }
    render json: response, status: :bad_request
  end
end
