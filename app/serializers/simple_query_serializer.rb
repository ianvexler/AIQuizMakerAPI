class SimpleQuerySerializer < ActiveModel::Serializer
  attributes :id, :active, :draft, :version
end
