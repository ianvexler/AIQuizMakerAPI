# == Schema Information
#
# Table name: course_groups
#
#  id              :bigint           not null, primary key
#  archived        :boolean          default(FALSE)
#  name            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_course_groups_on_name_and_organization_id  (name,organization_id) UNIQUE
#  index_course_groups_on_organization_id           (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class CourseGroup < ApplicationRecord
  belongs_to :organization
  has_many :courses, dependent: :restrict_with_exception
end
