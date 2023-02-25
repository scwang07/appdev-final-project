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
end
