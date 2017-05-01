class CreateRestrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :restrooms do |t|
      t.string :restaurant_name
      t.string :location
    end
  end
end
