class CreateCuisineRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :cuisine_restaurants do |t|
      t.integer :cuisine_id
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
