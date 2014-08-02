# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140802220905) do

  create_table "queries", force: true do |t|
    t.string   "route_id1"
    t.string   "route_id2"
    t.string   "parent_station_id1"
    t.string   "parent_station_id2"
    t.string   "stop_id1"
    t.string   "stop_id2"
    t.integer  "max_stops1"
    t.integer  "max_stops2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "results"
  end

  create_table "stop_times", id: false, force: true do |t|
    t.text    "trip_id"
    t.text    "stop_id"
    t.text    "arrival_time"
    t.text    "departure_time"
    t.integer "stop_sequence"
    t.integer "pickup_type"
    t.integer "drop_off_type"
  end

  create_table "stops", id: false, force: true do |t|
    t.text    "stop_id"
    t.text    "stop_name"
    t.float   "stop_lat"
    t.float   "stop_lon"
    t.integer "location_type"
    t.text    "parent_station"
  end

  create_table "subway_routes", id: false, force: true do |t|
    t.text    "agency_id"
    t.text    "route_id"
    t.text    "route_short_name"
    t.text    "route_long_name"
    t.integer "route_type"
    t.text    "route_url"
    t.text    "route_color"
    t.text    "route_text_color"
  end

  create_table "transfers", id: false, force: true do |t|
    t.text    "from_stop_id"
    t.text    "to_stop_id"
    t.integer "transfer_type"
    t.integer "min_transfer_time"
  end

  create_table "trips", id: false, force: true do |t|
    t.text    "route_id"
    t.text    "trip_id"
    t.text    "service_id"
    t.text    "trip_headsign"
    t.integer "direction_id"
    t.integer "shape_id"
  end

end
