# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  length     :integer          default(10)
#  quiz_type  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Quiz < ApplicationRecord
  has_many :topic_quizzes
  has_many :topics, through: :topic_quizzes
  has_many :quiz_difficulties
  has_many :difficulties, through: :quiz_difficulties
  has_many :quiz_questions
  has_many :questions, through: :quiz_questions
end
