# == Schema Information
#
# Table name: cuisine_restaurants
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cuisine_id    :integer
#  restaurant_id :integer
#
class CuisineRestaurant < ApplicationRecord
  belongs_to(:restaurant, { :required => true, :class_name => "Restaurant", :foreign_key => "restaurant_id" })
  belongs_to(:cuisine, { :required => true, :class_name => "Cuisine", :foreign_key => "cuisine_id" })
end
