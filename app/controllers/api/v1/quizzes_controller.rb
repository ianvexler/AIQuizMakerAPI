class Api::V1::QuizzesController < ActionController::API
  before_action :set_api_client

  def create
    quiz_params = params[:quiz]

    begin
      @quiz_data = @gemini_api_client.create_quiz(quiz_params[:title])
    rescue Faraday::BadRequestError => e
      response = {
        message: e.message,
        body: e.response[:body]
      }

      return render json: response, status: :bad_request
    end

    @quiz = Quiz.create(
      title: quiz_params[:title],
      goal: quiz_params[:goal],
      instructions: quiz_params[:instructions],
      quiz_data: @quiz_data
    )

    return render json: { quiz: @quiz }, status: :ok if @quiz.save

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  private

  def set_api_client
    @gemini_api_client = GeminiApiService.instance
  end
end
