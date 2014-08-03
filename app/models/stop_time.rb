class StopTime < ActiveRecord::Base
  belongs_to :trip
  belongs_to :stop

  delegate :subway_route, to: :trip

  # direction_id is not needed since the stop uniquely determines the direction
  # stop actually represents a platform so there can be multiple lines for a stop, but all going in the same direction
  # parent stations (without an associated direction) are not linked to any trips

  def self.next_stop(stop_time) # next stop along the route, if we get on the train where will we go?
    where("stop_times.trip_id = ? AND stop_times.stop_sequence = ?", stop_time.trip_id, stop_time.stop_sequence+1).limit(1)[0]
  end 

  def next_stop
    self.class.next_stop(self)
  end 

  def self.next_departing_train(stop, route, datetime)
    next_departing_train_sameday = self.next_departing_train_sameday(stop, route, datetime)

    if next_departing_train_sameday
      next_departing_train_sameday # fri
    elsif next_departing_train_nextday = self.next_departing_train_nextday(stop, route, datetime)
      next_departing_train_nextday # sat
    elsif next_next = self.next_departing_train_nextday(stop, route, datetime + 86400)
      next_next
    elsif next_next_next = self.next_departing_train_nextday(stop, route, datetime + 172800)
      next_next_next
    end      
  end 

  def self.next_departing_train_sameday(stop, route, datetime)
    joins(:trip).
      where("stop_times.stop_id = ?", stop.stop_id).
      where("trips.route_id = ?", route.route_id).
      where("substr(stop_times.trip_id,10,3) = ?", datetime.day_of_week).
      where("to_timestamp(stop_times.departure_time, 'HH24:MI:SS') >= ?", datetime).
      order("to_timestamp(stop_times.departure_time, 'HH24:MI:SS')").limit(1)[0]
  end

  def self.next_departing_train_nextday(stop, route, datetime)
    joins(:trip).
      where("stop_times.stop_id = ?", stop.stop_id).
      where("trips.route_id = ?", route.route_id).
      where("substr(stop_times.trip_id,10,3) = ?", datetime.next_day_of_week).
      order("to_timestamp(stop_times.departure_time, 'HH24:MI:SS')").limit(1)[0]
  end
end