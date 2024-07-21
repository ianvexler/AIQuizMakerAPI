# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  archived    :boolean          default(FALSE)
#  description :string(255)
#  is_private  :boolean          default(TRUE)
#  name        :string(255)      not null
#  overview    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
  has_many :topic
end
