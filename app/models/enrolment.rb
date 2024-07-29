# == Schema Information
#
# Table name: enrolments
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  end_date   :datetime
#  start_date :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_enrolments_on_course_id  (course_id)
#  index_enrolments_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (user_id => users.id)
#
class Enrolment < ApplicationRecord
  belongs_to :user
  belongs_to :course
end
