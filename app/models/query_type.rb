# == Schema Information
#
# Table name: query_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_query_types_on_name  (name) UNIQUE
#
class QueryType < ApplicationRecord
  has_many :queries, dependent: :destroy

  before_destroy :check_has_queries?, if: -> { queries.exists? }

  validates :name, uniqueness: true

  private

  def check_has_queries?
    errors.add(:base, 'Cannot delete Query Type with associated Queries')
    throw :abort
  end
end
