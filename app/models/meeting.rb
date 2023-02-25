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
end
