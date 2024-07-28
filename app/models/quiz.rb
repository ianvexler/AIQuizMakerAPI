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
  has_many :topic_quizzes, dependent: :destroy
  has_many :topics, through: :topic_quizzes
  has_many :quiz_difficulties, dependent: :destroy
  has_many :difficulties, through: :quiz_difficulties
  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions
  has_many :user_quizzes, dependent: :destroy
  has_many :users, through: :user_quizzes
end
