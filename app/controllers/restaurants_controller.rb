class RestaurantsController < ApplicationController
  def index
    matching_restaurants = Restaurant.all

    @list_of_restaurants = matching_restaurants.order({ :created_at => :desc })

    render({ :template => "restaurants/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_restaurants = Restaurant.where({ :id => the_id })

    @the_restaurant = matching_restaurants.at(0)

    render({ :template => "restaurants/show.html.erb" })
  end

  def create
    the_restaurant = Restaurant.new
    the_restaurant.name = params.fetch("query_name")
    the_restaurant.description = params.fetch("query_description")
    the_restaurant.location = params.fetch("query_location")
    the_restaurant.reservation_possible = params.fetch("query_reservation_possible", false)

    if the_restaurant.valid?
      the_restaurant.save
      redirect_to("/restaurants", { :notice => "Restaurant created successfully." })
    else
      redirect_to("/restaurants", { :alert => the_restaurant.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_restaurant = Restaurant.where({ :id => the_id }).at(0)

    the_restaurant.name = params.fetch("query_name")
    the_restaurant.description = params.fetch("query_description")
    the_restaurant.location = params.fetch("query_location")
    the_restaurant.reservation_possible = params.fetch("query_reservation_possible", false)

    if the_restaurant.valid?
      the_restaurant.save
      redirect_to("/restaurants/#{the_restaurant.id}", { :notice => "Restaurant updated successfully."} )
    else
      redirect_to("/restaurants/#{the_restaurant.id}", { :alert => the_restaurant.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_restaurant = Restaurant.where({ :id => the_id }).at(0)

    the_restaurant.destroy

    redirect_to("/restaurants", { :notice => "Restaurant deleted successfully."} )
  end
end
