class QueryTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :latest_version, :latest_version_id

  def latest_version
    object.latest_version
  end

  def latest_version_id
    object.latest_version_id
  end
end
