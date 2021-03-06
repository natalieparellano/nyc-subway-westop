class CreateMigration < ActiveRecord::Migration
  def change
    create_table "stop_times", id: false, force: true do |t|
      t.text    "trip_id"
      t.text    "stop_id"
      t.text    "arrival_time"
      t.text    "departure_time"
      t.integer "stop_sequence"
      t.text    "pickup_type"
      t.text    "drop_off_type"
    end

    create_table "stops", id: false, force: true do |t|
      t.text    "stop_id"
      t.text    "stop_name"
      t.float   "stop_lat"
      t.float   "stop_lon"
      t.text    "location_type"
      t.text    "parent_station"
    end

    create_table "subway_routes", id: false, force: true do |t|
      t.text    "agency_id"
      t.text    "route_id"
      t.text    "route_short_name"
      t.text    "route_long_name"
      t.text    "route_type"
      t.text    "route_url"
      t.text    "route_color"
      t.text    "route_text_color"
    end

    create_table "transfers", id: false, force: true do |t|
      t.text    "from_stop_id"
      t.text    "to_stop_id"
      t.text    "transfer_type"
      t.text    "min_transfer_time"
    end

    create_table "trips", id: false, force: true do |t|
      t.text    "route_id"
      t.text    "trip_id"
      t.text    "service_id"
      t.text    "trip_headsign"
      t.text    "direction_id"
      t.text    "shape_id"
    end
  end
end
