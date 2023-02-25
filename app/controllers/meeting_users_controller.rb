class MeetingUsersController < ApplicationController
  def index
    matching_meeting_users = MeetingUser.all

    @list_of_meeting_users = matching_meeting_users.order({ :created_at => :desc })

    render({ :template => "meeting_users/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_meeting_users = MeetingUser.where({ :id => the_id })

    @the_meeting_user = matching_meeting_users.at(0)

    render({ :template => "meeting_users/show.html.erb" })
  end

  def create
    the_meeting_user = MeetingUser.new
    the_meeting_user.meeting_id = params.fetch("query_meeting_id")
    the_meeting_user.user_id = params.fetch("query_user_id")

    if the_meeting_user.valid?
      the_meeting_user.save
      redirect_to("/meeting_users", { :notice => "Meeting user created successfully." })
    else
      redirect_to("/meeting_users", { :alert => the_meeting_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_meeting_user = MeetingUser.where({ :id => the_id }).at(0)

    the_meeting_user.meeting_id = params.fetch("query_meeting_id")
    the_meeting_user.user_id = params.fetch("query_user_id")

    if the_meeting_user.valid?
      the_meeting_user.save
      redirect_to("/meeting_users/#{the_meeting_user.id}", { :notice => "Meeting user updated successfully."} )
    else
      redirect_to("/meeting_users/#{the_meeting_user.id}", { :alert => the_meeting_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_meeting_user = MeetingUser.where({ :id => the_id }).at(0)

    the_meeting_user.destroy

    redirect_to("/meeting_users", { :notice => "Meeting user deleted successfully."} )
  end
end
