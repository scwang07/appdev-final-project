# == Schema Information
#
# Table name: meeting_users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :integer
#  user_id    :integer
#
class MeetingUser < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:meeting, { :required => true, :class_name => "Meeting", :foreign_key => "meeting_id" })
end
