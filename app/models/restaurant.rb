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
  validates(:name, { :presence => true })
  validates(:location, { :presence => true })

  has_many(:cuisine_restaurants, { :class_name => "CuisineRestaurant", :foreign_key => "restaurant_id", :dependent => :destroy })
  has_many(:cuisines, { :through => :cuisine_restaurants, :source => :cuisine })
  has_many(:meetings, { :class_name => "Meeting", :foreign_key => "restaurant_id", :dependent => :destroy })
end
