class AddMeetingCriteriaToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :age_min, :integer
    add_column :meetings, :age_max, :integer
    add_column :meetings, :sex, :string
  end
end
