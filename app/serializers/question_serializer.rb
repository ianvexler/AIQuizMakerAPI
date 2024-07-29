class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :archived, :confidence, :content, :flagged

  belongs_to :difficulty
  belongs_to :flagged_by
  has_many :question_options
end
