# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  dob             :date
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  sex             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:meeting_users, { :class_name => "MeetingUser", :foreign_key => "user_id", :dependent => :nullify })
  has_many(:meetings, { :through => :meeting_users, :source => :meeting })

  def age
    user_age = ((Time.zone.now - self.dob.to_time) / 1.year.seconds).floor
    return user_age
  end
end
