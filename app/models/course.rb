# == Schema Information
#
# Table name: courses
#
#  id              :bigint           not null, primary key
#  archived        :boolean          default(FALSE)
#  description     :text(65535)
#  is_private      :boolean          default(TRUE)
#  name            :string(255)      not null
#  overview        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  course_group_id :bigint           not null
#
# Indexes
#
#  index_courses_on_course_group_id  (course_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_group_id => course_groups.id)
#
class Course < ApplicationRecord
  has_many :topic, dependent: :restrict_with_exception
  belongs_to :course_group
end
