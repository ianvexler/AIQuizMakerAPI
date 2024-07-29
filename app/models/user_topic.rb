# == Schema Information
#
# Table name: user_topics
#
#  id         :bigint           not null, primary key
#  progress   :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_topics_on_topic_id  (topic_id)
#  index_user_topics_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
class UserTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :user
end
