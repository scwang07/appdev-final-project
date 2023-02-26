class MeetingsController < ApplicationController
  def index
    matching_meetings = @current_user.meetings
    @list_of_meetings = matching_meetings.order({ :created_at => :desc })


    render({ :template => "meetings/index.html.erb" })
  end

  def from_restaurant
    restaurant_id = params.fetch("path_id")
    matching_restaurants = Restaurant.where({:id => restaurant_id})
    @the_restaurant = matching_restaurants.first
    render({:template => "meetings/restaurant.html.erb"})
  end

  def available_requests
    user_age = @current_user.age
    user_gender = @current_user.sex
    matching_meetings = Meeting.where("age_max > ? OR age_max IS NULL", user_age)
    matching_meetings = Meeting.where("age_min < ? OR age_min IS NULL", user_age)
    matching_meetings = matching_meetings.where({:sex => user_gender}).or(matching_meetings.where({:sex => "nil"}))
    matching_meetings = matching_meetings.where({:status => "Pending"})

    @list_of_meetings = matching_meetings.order({ :created_at => :desc })

    render({ :template => "meetings/requests.html.erb" })
  end


  def show
    the_id = params.fetch("path_id")

    matching_meetings = Meeting.where({ :id => the_id })

    @the_meeting = matching_meetings.at(0)
    @the_meeting_users = MeetingUser.where({:meeting_id => the_id})

    @user_one_id = @the_meeting_users.where({:user_order => 1}).first.user_id
    
    @user_two_id = @the_meeting_users.where({:user_order => 2}).first
    if @user_two_id != nil
      @user_two_id = @user_two_id.user_id
    end

    render({ :template => "meetings/show.html.erb" })
  end

  def create
    the_meeting = Meeting.new
    the_meeting.time = params.fetch("query_time")
    the_meeting.restaurant_id = params.fetch("query_restaurant_id")
    the_meeting.status = params.fetch("query_status")
    the_meeting.reservation_status = params.fetch("query_reservation_status")
    the_meeting.age_min = params.fetch("query_age_min")
    the_meeting.age_max = params.fetch("query_age_max")
    the_meeting.sex = params.fetch("query_req_gender")


    if the_meeting.valid?
      the_meeting.save
      the_meeting_user = MeetingUser.new
      the_meeting_user.meeting_id = the_meeting.id
      the_meeting_user.user_id = session[:user_id]
      the_meeting_user.user_order = 1
      the_meeting_user.save
      redirect_to("/meetings", { :notice => "Eat-up request created successfully!" })
    else
      redirect_to("/meetings", { :alert => the_meeting.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_meeting = Meeting.where({ :id => the_id }).at(0)

    the_meeting.time = params.fetch("query_time")
    the_meeting.restaurant_id = params.fetch("query_restaurant_id")
    the_meeting.status = params.fetch("query_status")
    the_meeting.reservation_status = params.fetch("query_reservation_status")
    the_meeting.age_min = params.fetch("query_age_min")
    the_meeting.age_max = params.fetch("query_age_max")
    the_meeting.sex = params.fetch("query_req_gender")

    if the_meeting.valid?
      the_meeting.save
      redirect_to("/meetings/#{the_meeting.id}", { :notice => "Eat-up updated successfully."} )
    else
      redirect_to("/meetings/#{the_meeting.id}", { :alert => the_meeting.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_meeting = Meeting.where({ :id => the_id }).at(0)

    the_meeting.destroy

    redirect_to("/meetings", { :notice => "Eat-up deleted successfully."} )
  end
end
