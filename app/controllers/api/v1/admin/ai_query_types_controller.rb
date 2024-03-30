class Api::V1::Admin::AiQueryTypesController < ActionController::API
  def index
    @ai_query_types = AiQueryType.all
    render json: { ai_query_types: @ai_query_types }, status: :ok
  end

  def create
    @ai_query_type = AiQueryType.new(ai_query_type_params)

    return render json: { ai_query_type: @ai_query_type }, status: :ok if @ai_query_type.save

    render json: { errors: @ai_query_type.errors }, status: :unprocessable_entity
  end

  def update
    @ai_query_type = AiQueryType.find(params[:id])

    return render json: { ai_query_type: @ai_query_type }, status: :ok if @ai_query_type.update(ai_query_type_params)

    render json: { errors: @ai_query_type.errors }, status: :unprocessable_entity
  end

  def destroy
    @ai_query_type = AiQueryType.find(params[:id])

    return head :ok if @ai_query_type.destroy

    render json: { errors: @ai_query_type.errors }, status: :unprocessable_entity
  end

  private

  def ai_query_type_params
    params.require(:ai_query_type).permit(:name)
  end
end
