class Api::V1::Admin::AiQueriesController < ActionController::API
  def index
    @ai_queries = AiQuery.all
    render json: @ai_queries, each_serializer: AiQuerySerializer, status: :ok
  end

  def show
    @ai_query = AiQuery.find(params[:id])
    render json: @ai_query, each_serializer: AiQuerySerializer, status: :ok
  end

  def update
    @ai_query = AiQuery.find(params[:id])
    @ai_query.json_format = params[:ai_query][:json_format].to_json

    return render json: @ai_query, each_serializer: AiQuerySerializer, status: :ok if @ai_query.update(ai_query_params)

    render json: { errors: @ai_query.errors }, status: :unprocessable_entity
  end

  def destroy
    @ai_query = AiQuery.find(params[:id])

    return head :ok if @ai_query.destroy

    render json: { errors: @ai_query.errors }, status: :unprocessable_entity
  end

  private

  def ai_query_params
    params.require(:ai_query).permit(:active, :draft, :text, :ai_query_type_id)
  end
end
