# == Schema Information
#
# Table name: queries
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(FALSE)
#  draft          :boolean          default(TRUE)
#  formatted_text :text(4294967295) not null
#  json_format    :text(4294967295) not null
#  text           :text(4294967295) not null
#  version        :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  query_type_id  :bigint           not null
#
# Indexes
#
#  index_queries_on_query_type_id  (query_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (query_type_id => query_types.id)
#
class Query < ApplicationRecord
  belongs_to :query_type

  before_create :set_version_number
  after_save :check_active

  validates :text, presence: true
  validates :formatted_text, presence: true
  validates :json_format, presence: true
  validates :query_type_id, presence: true

  private

  def set_version_number
    latest_version = query_type.queries.order(version: :desc).first

    self.version = (latest_version&.version || 0) + 1
  end

  def check_active
    return unless version

    queries = query_type.queries.where.not(id:)
    queries.update_all(active: false)
  end
end
