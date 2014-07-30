class SubwayRoute < ActiveRecord::Base
  self.primary_key = "route_id"
  has_many :trips, foreign_key: :route_id # this is needed so that the query looks for trips.route_id instead of trips.subway_route_id

  has_many :stop_times, through: :trips
  has_many :stops, through: :stop_times # duplication
end