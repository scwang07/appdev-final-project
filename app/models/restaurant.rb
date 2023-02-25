# == Schema Information
#
# Table name: restaurants
#
#  id                   :integer          not null, primary key
#  description          :text
#  location             :string
#  name                 :string
#  reservation_possible :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Restaurant < ApplicationRecord
end
