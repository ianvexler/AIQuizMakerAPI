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

  after_create :set_initial_query
  before_destroy :check_has_queries?, if: -> { ai_queries.exists? }

  private

  def check_has_queries?
    errors.add(:base, 'Cannot delete Query Type with associated Queries')
    throw :abort
  end

  def set_initial_query
    ai_queries.create(text: '', json_format: {}, draft: true) unless ai_queries.any?
  end
end
