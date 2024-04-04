class Api::V1::Admin::QueryTypes::QueriesController < ActionController::API
  rescue_from Faraday::BadRequestError, with: :handle_bad_request

  def index
    @query_type = QueryType.find(params[:query_type_id])
    @queries = @query_type.queries.order(version: :desc)

    render json: @queries, each_serializer: SimpleQuerySerializer, status: :ok
  end

def create
    @query = Query.new(query_params)
    @query.json_format = params[:query][:json_format].to_json
    @query.query_type_id = params[:query_type_id]
  
    if @query.save
      render json: @query, serializer: QuerySerializer, status: :ok
    else
      render json: { errors: @query.errors }, status: :unprocessable_entity
    end
  end

  def show
    @query = Query.find(params[:id])
    render json: @query, each_serializer: QuerySerializer, status: :ok
  end

  def update
    @query = Query.find(params[:id])
    @query.json_format = params[:query][:json_format].to_json

    return render json: @query, each_serializer: QuerySerializer, status: :ok if @query.update(query_params)

    render json: { errors: @query.errors }, status: :unprocessable_entity
  end

  def destroy
    @query = Query.find(params[:id])

    return head :ok if @query.destroy

    render json: { errors: @query.errors }, status: :unprocessable_entity
  end

  def test
    text = params[:text]
    json_format = params[:json_format]
    model = params[:model]

    if model == 'gpt'
      @open_ai_api_client = OpenAiApiService.instance
      response = @open_ai_api_client.test_query(text, json_format)

    else
      @gemini_api_client = GeminiApiService.instance
      response = @gemini_api_client.test_query(text, json_format)

    end
    return render json: response, status: :ok if response

    render json: { errors: 'There was an error testing the Query' }, status: :bad_request
  end

  private

  def query_params
    params.require(:query).permit(:active, :draft, :text, :formatted_text)
  end

  def handle_bad_request(exception)
    response = {
      message: exception.message,
      body: exception.response[:body]
    }
    render json: response, status: :bad_request
  end
end
