# == Schema Information
#
# Table name: user_quizzes
#
#  id         :bigint           not null, primary key
#  duration   :float(24)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_quizzes_on_quiz_id  (quiz_id)
#  index_user_quizzes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#  fk_rails_...  (user_id => users.id)
#
class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
end
