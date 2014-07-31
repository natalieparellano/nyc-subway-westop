class StopTime < ActiveRecord::Base
  belongs_to :trip
  belongs_to :stop

  delegate :subway_route, to: :trip

  def self.next_departing_train(stop, route, direction_id, datetime)
    next_departing_train_sameday = self.next_departing_train_sameday(stop, route, direction_id, datetime)

    next_departing_train_sameday ?
      next_departing_train_sameday : 
      self.next_departing_train_nextday(stop, route, direction_id, datetime)
  end 

  def self.next_departing_train_sameday(stop, route, direction_id, datetime)
    joins(:trip).
      where("stop_times.stop_id = ?", stop.stop_id).
      where("trips.route_id = ? AND trips.direction_id = ?", route.route_id, direction_id).
      where("substr(stop_times.trip_id,10,3) = ?", datetime.day_of_week).
      where("time(stop_times.departure_time) > ?", datetime.strftime('%T')).
      order("time(stop_times.departure_time)").limit(1)[0]
  end

  def self.next_departing_train_nextday(stop, route, direction_id, datetime)
    joins(:trip).
      where("stop_times.stop_id = ?", stop.stop_id).
      where("trips.route_id = ? AND trips.direction_id = ?", route.route_id, direction_id).
      where("substr(stop_times.trip_id,10,3) = ?", datetime.next_day_of_week).
      order("time(stop_times.departure_time)").limit(1)[0]
  end
end