class Trip < ActiveRecord::Base
  self.primary_key = 'trip_id'
  belongs_to :subway_route, foreign_key: :route_id
  has_many   :stop_times

  has_many   :stops, through: :stop_times
end