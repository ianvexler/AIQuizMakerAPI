class QuizSerializer < ActiveModel::Serializer
  attributes :id, :length, :quiz_type, :created_at

  has_many :topics
  has_many :difficulties
  has_many :questions
end
