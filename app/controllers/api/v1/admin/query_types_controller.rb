class Api::V1::Admin::QueryTypesController < ActionController::API
  def index
    @query_types = QueryType.all
    render json: @query_types, each_serializer: QueryTypeSerializer, status: :ok
  end

  def create
    @query_type = QueryType.new(query_type_params)

    return render json: @query_type, each_serializer: QueryTypeSerializer, status: :ok if @query_type.save

    render json: { errors: @query_type.errors }, status: :unprocessable_entity
  end

  def update
    @query_type = QueryType.find(params[:id])

    if @query_type.update(query_type_params)
      return render json: @query_type, each_serializer: QueryTypeSerializer, status: :ok
    end

    render json: { errors: @query_type.errors }, status: :unprocessable_entity
  end

  def destroy
    @query_type = QueryType.find(params[:id])

    return head :ok if @query_type.destroy

    render json: { errors: @query_type.errors }, status: :unprocessable_entity
  end

  private

  def query_type_params
    params.require(:query_type).permit(:name)
  end
end
