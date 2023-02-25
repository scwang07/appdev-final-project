class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.datetime :time
      t.integer :restaurant_id
      t.string :status
      t.string :reservation_status

      t.timestamps
    end
  end
end
