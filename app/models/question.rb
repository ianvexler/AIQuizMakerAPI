# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  archived      :boolean          default(FALSE), not null
#  confidence    :integer          default(0)
#  content       :string(255)      not null
#  flagged       :boolean          default(FALSE), not null
#  hints         :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  difficulty_id :bigint           not null
#  flagged_by_id :bigint
#  topic_id      :bigint
#
# Indexes
#
#  index_questions_on_difficulty_id  (difficulty_id)
#  index_questions_on_flagged_by_id  (flagged_by_id)
#  index_questions_on_topic_id       (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (difficulty_id => difficulties.id)
#  fk_rails_...  (flagged_by_id => users.id)
#  fk_rails_...  (topic_id => topics.id)
#
class Question < ApplicationRecord
  serialize :hints, JSON

  belongs_to :difficulty
  has_many :question_options, dependent: :restrict_with_exception
  has_many :quiz_questions, dependent: :restrict_with_exception
  has_many :quizzes, through: :quiz_questions
  belongs_to :flagged_by, class_name: 'User', optional: true
  has_many :question_responses, dependent: :restrict_with_exception
  belongs_to :topic

  def self.unassigned_to_user_quizzes(user_id, topic_id)
    # All quizzes the user is enrolled in
    user_quiz_ids = User.find(user_id).quizzes.pluck(:id)
    
    # Fetch all questions for the given subject that are not already in the user's quizzes
    Question
      .joins(:topic)
      .where(topic_id: topic_id)
      .where.not(id: QuizQuestion.where(quiz_id: user_quiz_ids).pluck(:question_id))
  end
end
