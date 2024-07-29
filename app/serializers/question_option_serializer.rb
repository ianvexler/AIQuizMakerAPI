class QuestionOptionSerializer < ActiveModel::Serializer
  attributes :id, :is_correct, :value
end
