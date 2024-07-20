# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  archived    :boolean
#  description :string(255)
#  name        :string(255)      not null
#  overview    :string(255)
#  private     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
end
