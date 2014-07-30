class Stop < ActiveRecord::Base
  self.primary_key = 'stop_id'
  has_many :stop_times

  has_many :trips, through: :stop_times
  has_many :subway_routes, through: :trips

  def next_departing_train(route, datetime)
    stop_times.next_departing_train(self, route, datetime)
  end 

  def time_til_next_train(route, datetime)
    next_train_time = next_departing_train(route, datetime).departure_time.parse_from_hms
    now_time = datetime.parse_from_hms
    
    seconds = next_train_time - now_time

    # if the next train is departing on the following day, seconds will be negative
    if seconds < 0
      seconds += 86400
    end 

    (seconds / 60).to_f
  end  
end