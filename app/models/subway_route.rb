class SubwayRoute < ActiveRecord::Base
  self.primary_key = "route_id"
  has_many :trips, foreign_key: :route_id

  has_many :stop_times, through: :trips
  has_many :stops, through: :stop_times
end