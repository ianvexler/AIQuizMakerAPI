# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  exp                    :datetime
#  jti                    :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  rt                     :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organization_id        :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_exp                   (exp)
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_organization_id       (organization_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_rt                    (rt)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :organization
  has_many :user_topics, dependent: :destroy
  has_many :topics, through: :user_topics
  has_many :enrolments, dependent: :destroy
  has_many :courses, through: :enrolments
  has_many :user_quizzes, dependent: :destroy
  has_many :quizzes, through: :user_quizzes
  has_many :question_responses, dependent: :restrict_with_exception

  # Temporary for testing
  after_create :setup_enrolments

  def setup_enrolments
    organization.course_groups.first.courses.each do |course|
      Enrolment.create do |e|
        e.user = self
        e.course = course
        e.active = true
        e.start_date = DateTime.now
      end
    end
  end

  def self.find_using_refresh_token(refresh_token)
    # validate token
    Warden::JWTAuth::TokenDecoder.new.call(refresh_token)

    where(rt: refresh_token).first
  end

  def generate_refresh_token
    self.rt = Warden::JWTAuth::TokenEncoder.new.call({ 'exp' => 1.year.from_now.to_i })
    save(validate: false)
  end

  def self.revoke_jwt(_payload, user)
    user.revoke_access_and_refresh_tokens
  end

  def generate_access_and_refresh_tokens
    generate_refresh_token
    update_attribute(:jti, self.class.generate_jti)

    save(validate: false)
  end

  def revoke_access_and_refresh_tokens
    # generate a new token to invalidate any existing ones
    generate_access_and_refresh_tokens
  end
end
