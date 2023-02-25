class CuisinesController < ApplicationController
  def index
    matching_cuisines = Cuisine.all

    @list_of_cuisines = matching_cuisines.order({ :created_at => :desc })

    render({ :template => "cuisines/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cuisines = Cuisine.where({ :id => the_id })

    @the_cuisine = matching_cuisines.at(0)

    render({ :template => "cuisines/show.html.erb" })
  end

  def create
    the_cuisine = Cuisine.new
    the_cuisine.name = params.fetch("query_name")

    if the_cuisine.valid?
      the_cuisine.save
      redirect_to("/cuisines", { :notice => "Cuisine created successfully." })
    else
      redirect_to("/cuisines", { :alert => the_cuisine.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cuisine = Cuisine.where({ :id => the_id }).at(0)

    the_cuisine.name = params.fetch("query_name")

    if the_cuisine.valid?
      the_cuisine.save
      redirect_to("/cuisines/#{the_cuisine.id}", { :notice => "Cuisine updated successfully."} )
    else
      redirect_to("/cuisines/#{the_cuisine.id}", { :alert => the_cuisine.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cuisine = Cuisine.where({ :id => the_id }).at(0)

    the_cuisine.destroy

    redirect_to("/cuisines", { :notice => "Cuisine deleted successfully."} )
  end
end
