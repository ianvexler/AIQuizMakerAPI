# == Schema Information
#
# Table name: topic_quizzes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_topic_quizzes_on_quiz_id   (quiz_id)
#  index_topic_quizzes_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#  fk_rails_...  (topic_id => topics.id)
#
class TopicQuiz < ApplicationRecord
  belongs_to :quiz
  belongs_to :topic
end
