class QuerySerializer < ActiveModel::Serializer
  attributes :id, :text, :formatted_text, :json_format, :active, :draft, :version

  belongs_to :query_type

  attribute :json_format do
    JSON.parse(object.json_format)
  end
end
