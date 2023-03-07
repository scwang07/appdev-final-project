class MeetingsController < ApplicationController
  def index
    matching_meetings = @current_user.meetings
    @list_of_meetings = matching_meetings.order({ :created_at => :desc })

    @list_of_created_meetings = @current_user.meetings.joins(:meeting_users).where("meeting_users.user_id = ? AND meeting_users.user_order = ?", @current_user.id, 1).order(created_at: :desc).distinct
    @list_of_created_meetings = @list_of_created_meetings.where.not({ :status => "Cancelled" })
    @list_of_created_active_meetings = @list_of_created_meetings.where("time > ?", Time.now)

    @list_of_joined_meetings = @current_user.meetings.joins(:meeting_users).where("meeting_users.user_id = ? AND meeting_users.user_order != ?", @current_user.id, 1).order(created_at: :desc).distinct
    @list_of_joined_meetings = @list_of_joined_meetings.where.not({ :status => "Cancelled" })
    @list_of_joined_active_meetings = @list_of_joined_meetings.where("time > ?", Time.now)

    render({ :template => "meetings/index.html.erb" })
  end

  def from_restaurant
    restaurant_id = params.fetch("path_id")
    matching_restaurants = Restaurant.where({ :id => restaurant_id })
    @the_restaurant = matching_restaurants.first
    render({ :template => "meetings/restaurant.html.erb" })
  end

  def available_requests
    user_age = @current_user.age
    user_gender = @current_user.sex

    matching_meetings = Meeting.where("age_max > ? OR age_max IS NULL", user_age)
    matching_meetings = Meeting.where("age_min < ? OR age_min IS NULL", user_age)
    matching_meetings = matching_meetings.where({ :sex => user_gender }).or(matching_meetings.where({ :sex => "nil" }))
    matching_meetings = matching_meetings.where({ :status => "Pending" })

    @q = matching_meetings.ransack(params[:q])
    @list_of_meetings = @q.result.order({ :created_at => :desc })
    @list_of_active_meetings = @list_of_meetings.where("time > ?", Time.now)

    render({ :template => "meetings/requests.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_meetings = Meeting.where({ :id => the_id })

    @the_meeting = matching_meetings.at(0)
    @the_meeting_users = MeetingUser.where({ :meeting_id => the_id })
    @this_meeting_user = @the_meeting_users.where({ :user_id => @current_user.id }).at(0)

    render({ :template => "meetings/show.html.erb" })
  end

  def create
    the_meeting = Meeting.new
    restaurant_name = params.fetch("query_restaurant_name")
    the_meeting.time = params.fetch("query_time")
    the_meeting.time = the_meeting.time.advance(hours: +6)
    puts "*************"
    puts "#{the_meeting.time}"
    puts the_meeting.time.class
    puts "**************"

    the_meeting.restaurant_id = Restaurant.where({ :name => restaurant_name }).first.id
    the_meeting.status = params.fetch("query_status")
    the_meeting.reservation_status = params.fetch("query_reservation_status")
    the_meeting.age_min = params.fetch("query_age_min")
    the_meeting.age_max = params.fetch("query_age_max")
    the_meeting.sex = params.fetch("query_req_gender")
    the_meeting.max_seats = params.fetch("query_max_seats")

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
    the_meeting.max_seats = params.fetch("query_max_seats")

    if the_meeting.valid?
      the_meeting.save
      redirect_to("/meetings/#{the_meeting.id}", { :notice => "Eat-up updated successfully." })
    else
      redirect_to("/meetings/#{the_meeting.id}", { :alert => the_meeting.errors.full_messages.to_sentence })
    end
  end

  def review
    the_id = params.fetch("path_id")
    the_meeting = Meeting.where({ :id => the_id}).at(0)
    render({:template => "/meetings/review.html.erb"})
  end

  def destroy
    the_id = params.fetch("path_id")
    the_meeting = Meeting.where({ :id => the_id }).at(0)

    the_meeting.status = "Cancelled"
    the_meeting.save

    redirect_to("/meetings/history", { :notice => "Eat-up cancelled successfully." })
  end

  def display_history
    matching_meetings = @current_user.meetings
    @list_of_cancelled_meetings = matching_meetings.where({ :status => "Cancelled" })
    @list_of_past_meetings = matching_meetings.where("time < ?", Time.now)
    @list_of_past_uncancelled_meetings = @list_of_past_meetings.where.not({ :status => "Cancelled" })
    render({ :template => "/meetings/history.html.erb" })
  end
end
