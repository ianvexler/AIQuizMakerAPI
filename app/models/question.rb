# == Schema Information
#
# Table name: questions
#
#  id            :bigint           not null, primary key
#  archived      :boolean          default(FALSE), not null
#  confidence    :integer          default(0)
#  content       :string(255)      not null
#  flagged       :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  difficulty_id :bigint           not null
#
# Indexes
#
#  index_questions_on_difficulty_id  (difficulty_id)
#
# Foreign Keys
#
#  fk_rails_...  (difficulty_id => difficulties.id)
#
class Question < ApplicationRecord
  belongs_to :difficulty
  has_many :question_options, dependent: :restrict_with_exception
end
