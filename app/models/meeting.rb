# == Schema Information
#
# Table name: meetings
#
#  id                 :integer          not null, primary key
#  age_max            :integer
#  age_min            :integer
#  max_seats          :integer
#  reservation_status :string
#  sex                :string
#  status             :string
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  restaurant_id      :integer
#
class Meeting < ApplicationRecord
  validates(:max_seats, { :presence => true })
  validates(:restaurant_id, { :presence => true })
  validates(:time, { :presence => true })

  has_many(:meeting_users, { :class_name => "MeetingUser", :foreign_key => "meeting_id", :dependent => :nullify })
  has_many(:users, { :through => :meeting_users, :source => :user })
  belongs_to(:restaurant, { :required => true, :class_name => "Restaurant", :foreign_key => "restaurant_id" })

  def seats_remaining
    seats_remaining = self.max_seats - self.meeting_users.count
    return seats_remaining
  end
end
