# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  difficulty :string(255)      not null
#  length     :integer          default(10)
#  type       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Quiz < ApplicationRecord
end
