# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE)
#  name       :string(255)      not null
#  overview   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
end
