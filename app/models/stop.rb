class Stop < ActiveRecord::Base
  self.primary_key = 'stop_id'
  has_many :stop_times

  has_many :trips, through: :stop_times
  has_many :subway_routes, through: :trips # duplication

  has_many :to_transfers, foreign_key: "to_stop_id", class_name: "Transfer"
  has_many :from_transfers, foreign_key: "from_stop_id", class_name: "Transfer"

  has_many :users

  # Game plan

  # given a stop and a route (and maybe a time)

  # and another stop and route (and maybe a time)

  # do this...

  # for the first stop, find the next arriving train
  def next_departing_train(route, direction_id, datetime)
    stop_times.next_departing_train(self, route, direction_id, datetime)
  end 

  # we want the trip for the next arriving train
  def next_trip_and_stop_sequence(route, direction_id, datetime)
    next_train = next_departing_train(route, direction_id, datetime)

    return next_train.trip, next_train.stop_sequence
  end 

  # for that trip, we want to traverse the stops -- in either direction
  # just pick one direction to start with
  def traverse_stops(trip, stop_sequence)
    # we traverse the stops on the trip, at each station we need to check if there's a transfer

    # if there IS a transfer, then we need to branch off and start traversing the other trips

    # we do this until we've gone 15 stops (15 is an arbitrary limit, we can let the user adjust it)

    # once we're at the end, we need to return the end stop

    # this gives all possible stops for one user

  end 

  

  # we need to do the exact same thing as above for the second starting stop and route

  # this gives all possible stops for the other user

  # once we have all possible stops, we need to find all pairs of stops for which the difference in latitude and longitude is small

  # then lookup restaurants on yelp in these areas 

  def time_til_next_train(route, datetime)
    next_train_time = Time.parse(next_departing_train(route, datetime).departure_time)
    now_time = datetime.parse_from_hms
    
    seconds = next_train_time - now_time

    # if the next train is departing on the following day, seconds will be negative
    if seconds < 0
      seconds += 86400
    end 

    (seconds / 60).to_f
  end  
end