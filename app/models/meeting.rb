# == Schema Information
#
# Table name: meetings
#
#  id                 :integer          not null, primary key
#  reservation_status :string
#  status             :string
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  restaurant_id      :integer
#
class Meeting < ApplicationRecord
  has_many(:meeting_users, { :class_name => "MeetingUser", :foreign_key => "meeting_id", :dependent => :nullify })
  has_many(:users, { :through => :meeting_users, :source => :user })
end
