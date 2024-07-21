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
#  index_topics_on_course_id            (course_id)
#  index_topics_on_name_and_course_id   (name,course_id) UNIQUE
#  index_topics_on_order_and_course_id  (order,course_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
class Topic < ApplicationRecord
  belongs_to :course
  has_many :quizzes, through: :topic_quizzes

  validates :name, uniqueness: { scope: :course_id }
  validates :order, uniqueness: { scope: :course_id }
end
