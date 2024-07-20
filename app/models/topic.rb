# == Schema Information
#
# Table name: topics
#
#  id          :bigint           not null, primary key
#  archived    :boolean
#  description :string(255)
#  name        :string(255)      not null
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :bigint
#
# Indexes
#
#  index_topics_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
class Topic < ApplicationRecord
end
