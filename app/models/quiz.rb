# == Schema Information
#
# Table name: quizzes
#
#  id           :bigint           not null, primary key
#  goal         :string(255)
#  instructions :string(255)
#  quiz_data    :text(4294967295) not null
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Quiz < ApplicationRecord
end
