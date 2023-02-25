class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :location
      t.boolean :reservation_possible

      t.timestamps
    end
  end
end
