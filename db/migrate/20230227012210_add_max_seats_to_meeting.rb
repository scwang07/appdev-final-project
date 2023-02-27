class AddMaxSeatsToMeeting < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :max_seats, :integer
  end
end
