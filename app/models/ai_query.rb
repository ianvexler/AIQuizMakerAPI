# == Schema Information
#
# Table name: ai_queries
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(FALSE)
#  draft            :boolean          default(TRUE)
#  json_format      :text(4294967295) not null
#  text             :string(255)      not null
#  version          :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ai_query_type_id :bigint           not null
#
# Indexes
#
#  index_ai_queries_on_ai_query_type_id  (ai_query_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (ai_query_type_id => ai_query_types.id)
#
class AiQuery < ApplicationRecord
  belongs_to :ai_query_type

  before_create :set_version_number
  after_save :check_active

  private

  def set_version_number
    latest_version = ai_query_type.ai_queries.order(version: :desc).first

    self.version = (latest_version || 0) + 1
  end

  def check_active
    return unless version

    queries = ai_query_type.ai_queries.where.not(id:)
    queries.update_all(active: false)
  end
end
