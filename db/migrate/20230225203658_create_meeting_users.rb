class CreateMeetingUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_users do |t|
      t.integer :meeting_id
      t.integer :user_id

      t.timestamps
    end
  end
end
