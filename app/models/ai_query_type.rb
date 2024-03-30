# == Schema Information
#
# Table name: ai_query_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AiQueryType < ApplicationRecord
  has_many :ai_queries, dependent: :destroy

  before_destroy :check_has_queries?

  private

  def check_has_queries?
    return unless ai_queries.any?

    errors.add(:base, 'Cannot delete Query Type with associated Queries')
    throw :abort
  end
end
