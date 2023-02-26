# == Schema Information
#
# Table name: meetings
#
#  id                 :integer          not null, primary key
#  age_max            :integer
#  age_min            :integer
#  reservation_status :string
#  sex                :string
#  status             :string
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  restaurant_id      :integer
#
class Meeting < ApplicationRecord
  has_many(:meeting_users, { :class_name => "MeetingUser", :foreign_key => "meeting_id", :dependent => :nullify })
  has_many(:users, { :through => :meeting_users, :source => :user })
  belongs_to(:restaurant, { :required => true, :class_name => "Restaurant", :foreign_key => "restaurant_id" })
end
