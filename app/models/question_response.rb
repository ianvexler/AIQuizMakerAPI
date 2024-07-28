# == Schema Information
#
# Table name: question_responses
#
#  id                 :bigint           not null, primary key
#  duration           :integer
#  rating             :float(24)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  question_id        :bigint           not null
#  question_option_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_question_responses_on_question_id         (question_id)
#  index_question_responses_on_question_option_id  (question_option_id)
#  index_question_responses_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (question_option_id => question_options.id)
#  fk_rails_...  (user_id => users.id)
#
class QuestionResponse < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
