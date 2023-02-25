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
end
