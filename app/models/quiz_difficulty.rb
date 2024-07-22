# == Schema Information
#
# Table name: quiz_difficulties
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  difficulty_id :bigint           not null
#  quiz_id       :bigint           not null
#
# Indexes
#
#  index_quiz_difficulties_on_difficulty_id  (difficulty_id)
#  index_quiz_difficulties_on_quiz_id        (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (difficulty_id => difficulties.id)
#  fk_rails_...  (quiz_id => quizzes.id)
#
class QuizDifficulty < ApplicationRecord
  belongs_to :quiz
  belongs_to :difficulty
end
