# == Schema Information
#
# Table name: cuisines
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cuisine < ApplicationRecord
  has_many(:cuisine_restaurants, { :class_name => "CuisineRestaurant", :foreign_key => "cuisine_id", :dependent => :destroy })
  has_many(:restaurants, { :through => :cuisine_restaurants, :source => :restaurant })
end
