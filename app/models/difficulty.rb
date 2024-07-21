# == Schema Information
#
# Table name: difficulties
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_difficulties_on_name  (name) UNIQUE
#
class Difficulty < ApplicationRecord
  has_many :quizzes, through: :quiz_difficulties

  enum name: {
    beginner: 'Beginner',
    intermediate: 'Intermediate',
    expert: 'Expert'
  }
end
