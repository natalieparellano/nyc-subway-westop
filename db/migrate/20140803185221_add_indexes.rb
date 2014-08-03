class AddIndexes < ActiveRecord::Migration
  def change
    add_index :transfers, :from_stop_id
    add_index :stops, :parent_station
    add_index :stop_times, :trip_id
    add_index :stop_times, :stop_id
    add_index :trips, :route_id
    add_index :stops, :stop_id
    add_index :trips, :trip_id
    add_index :subway_routes, :route_id
  end
end
