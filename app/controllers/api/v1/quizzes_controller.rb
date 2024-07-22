class Api::V1::QuizzesController < ActionController::API
  rescue_from Faraday::BadRequestError, with: :handle_bad_request

  def create
    quiz_generator = QuizGeneratorService.instance(
      quiz_params[:topics],
      quiz_params[:difficulties],
      quiz_params[:type],
      quiz_params[:length]
    )

    quiz = quiz_generator.generate_quiz

    render json: { quiz: @quiz }, status: :ok if quiz.present? && @quiz.save

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  private

  def quiz_params
    params.require(:quiz).permit(:topics, :difficulties, :type)
  end

  def create_gemini
    @gemini_api_client = GeminiApiService.instance

    quiz_params = params[:quiz]

    @quiz_data = @gemini_api_client.create_quiz(quiz_params[:title])

    if @quiz_data.present?
      @quiz = Quiz.new(
        title: quiz_params[:title],
        goal: quiz_params[:goal],
        instructions: quiz_params[:instructions],
        quiz_data: @quiz_data.to_json
      )

      return render json: { quiz: @quiz }, status: :ok if @quiz.save
    end

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  def create_gpt
    @open_ai_api_client = OpenAiApiService.instance

    quiz_params = params[:quiz]

    @quiz_data = @open_ai_api_client.create_quiz(
      quiz_params[:title], quiz_params[:goal], quiz_params[:instructions]
    )

    if @quiz_data.present?
      @quiz = Quiz.new(
        title: quiz_params[:title],
        goal: quiz_params[:goal],
        instructions: quiz_params[:instructions],
        quiz_data: @quiz_data.to_json
      )

      return render json: { quiz: @quiz }, status: :ok if @quiz.save
    end

    render json: { errors: 'There was an error generating the quiz' }, status: :bad_request
  end

  def handle_bad_request(exception)
    response = {
      message: exception.message,
      body: exception.response[:body]
    }
    render json: response, status: :bad_request
  end
end
