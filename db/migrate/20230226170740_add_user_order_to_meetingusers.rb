class AddUserOrderToMeetingusers < ActiveRecord::Migration[6.0]
  def change
    add_column :meeting_users, :user_order, :integer
  end
end
