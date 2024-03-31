class AiQuerySerializer < ActiveModel::Serializer
  attributes :id, :text, :json_format, :active, :draft, :version

  belongs_to :ai_query_type

  attribute :json_format do
    JSON.parse(object.json_format)
  end
end
