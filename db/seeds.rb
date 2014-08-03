# Reset the db
SubwayRoute.destroy_all
StopTime.destroy_all
Stop.destroy_all
Transfer.destroy_all
Trip.destroy_all

# seed from csv
seed_routes = "
  COPY subway_routes 
  FROM '#{Rails.root}/db/export-formatted-csv/routes_no_desc.csv' 
  DELIMITER ',' CSV"
ActiveRecord::Base.connection.execute seed_routes

seed_stop_times = "
  COPY stop_times 
  FROM '#{Rails.root}/db/export-formatted-csv/stop_times.csv' 
  DELIMITER ',' CSV"
ActiveRecord::Base.connection.execute seed_stop_times

seed_stops = "
  COPY stops 
  FROM '#{Rails.root}/db/export-formatted-csv/stops.csv' 
  DELIMITER ',' CSV"
ActiveRecord::Base.connection.execute seed_stops

seed_transfers = "
  COPY transfers 
  FROM '#{Rails.root}/db/export-formatted-csv/transfers.csv' 
  DELIMITER ',' CSV"
ActiveRecord::Base.connection.execute seed_transfers

seed_trips = "
  COPY trips 
  FROM '#{Rails.root}/db/export-formatted-csv/trips.csv' 
  DELIMITER ',' CSV"
ActiveRecord::Base.connection.execute seed_trips