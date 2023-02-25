class CuisineRestaurantsController < ApplicationController
  def index
    matching_cuisine_restaurants = CuisineRestaurant.all

    @list_of_cuisine_restaurants = matching_cuisine_restaurants.order({ :created_at => :desc })

    render({ :template => "cuisine_restaurants/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cuisine_restaurants = CuisineRestaurant.where({ :id => the_id })

    @the_cuisine_restaurant = matching_cuisine_restaurants.at(0)

    render({ :template => "cuisine_restaurants/show.html.erb" })
  end

  def create
    the_cuisine_restaurant = CuisineRestaurant.new
    the_cuisine_restaurant.cuisine_id = params.fetch("query_cuisine_id")
    the_cuisine_restaurant.restaurant_id = params.fetch("query_restaurant_id")

    if the_cuisine_restaurant.valid?
      the_cuisine_restaurant.save
      redirect_to("/cuisine_restaurants", { :notice => "Cuisine restaurant created successfully." })
    else
      redirect_to("/cuisine_restaurants", { :alert => the_cuisine_restaurant.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cuisine_restaurant = CuisineRestaurant.where({ :id => the_id }).at(0)

    the_cuisine_restaurant.cuisine_id = params.fetch("query_cuisine_id")
    the_cuisine_restaurant.restaurant_id = params.fetch("query_restaurant_id")

    if the_cuisine_restaurant.valid?
      the_cuisine_restaurant.save
      redirect_to("/cuisine_restaurants/#{the_cuisine_restaurant.id}", { :notice => "Cuisine restaurant updated successfully."} )
    else
      redirect_to("/cuisine_restaurants/#{the_cuisine_restaurant.id}", { :alert => the_cuisine_restaurant.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cuisine_restaurant = CuisineRestaurant.where({ :id => the_id }).at(0)

    the_cuisine_restaurant.destroy

    redirect_to("/cuisine_restaurants", { :notice => "Cuisine restaurant deleted successfully."} )
  end
end
