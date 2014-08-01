class Stop < ActiveRecord::Base
  self.primary_key = 'stop_id'
  has_many :stop_times

  has_many :trips, through: :stop_times
  has_many :subway_routes, through: :trips # duplication

  has_many :to_transfers, foreign_key: "to_stop_id", class_name: "Transfer"
  has_many :from_transfers, foreign_key: "from_stop_id", class_name: "Transfer"

  has_many :users

  POSSIBLE_TRIPS = []

  def self.possible_trips
    POSSIBLE_TRIPS
  end

  # Game plan
  # just pick one direction to start with

  # given a stop and a route (and maybe a time)
  # and another stop and route (and maybe a time)

  # do this... 

  # for that trip, we want to traverse the stops 

  def find_possible_trips(starting_route, starting_time, max_stops, stops_visited=[])
    self.class.possible_trips.clear
    traverse_stops(starting_route, starting_time, max_stops, stops_visited=[])
    self.class.possible_trips #.uniq
  end 

  def traverse_stops(starting_route, starting_time, max_stops, stops_visited=[])
    
    # setup initial state
    current_platform = self
    current_time = starting_time
    next_train = current_platform.next_departing_train(starting_route, current_time)

    # check if the next stop exists, and is a valid stop
    next_stop_time = next_train.next_stop if next_train

    puts "########## The time is #{current_time}; the current platform is #{current_platform.stop_name}"
    puts "########## The next #{next_train.subway_route.route_short_name} train will arrive at #{next_train.arrival_time}" if next_train
    puts "########## The next stop on the train is #{next_stop_time.stop.stop_name}" if next_stop_time

    if next_stop_time && !stops_visited.include?(next_stop_time.stop.parent_station) &&
      !self.class.possible_trips.include?(stops_visited.dup.push(next_stop_time.stop.parent_station))
      
      # move to the next stop
      current_platform = next_stop_time.stop
      current_time = Time.parse(next_stop_time.arrival_time.adjust_mod_24) # need to figure out what is the best way to deal with hours greater than 24
      this_stop_time = next_stop_time

      # record movement
      stops_visited << current_platform.parent_station
      self.class.possible_trips << stops_visited
      puts "########## Moved to the next stop"
      puts "########## The time is #{current_time}; the current platform is #{current_platform.stop_name}"

      # check if we need to make any more stops
      while stops_visited.size < max_stops

        # check for transfers
        parent_station = Stop.find(current_platform.parent_station)
        transfer_ids = Transfer.where("transfers.from_stop_id = ?", parent_station.stop_id).pluck(:to_stop_id)
        puts "########## There are #{transfer_ids.size} transfers from #{current_platform.stop_name}"

        # find platforms for each transfer, reject invalid transfers (same line, opposite direction)
        child_platforms = Stop.where("parent_station IN (?)", transfer_ids).reject{ |p| 
          p.parent_station == current_platform.parent_station && p != current_platform
        } if transfer_ids && transfer_ids.size > 0
        child_platforms.each { |p| puts "########## You can transfer from #{current_platform.stop_id} to #{p.stop_id}" } if child_platforms

        # find next train for each valid platform
        child_stop_times = child_platforms.collect { |platform|
          routes = platform.subway_routes.uniq
          routes.collect { |route|
            platform.next_departing_train(route, current_time)
          }
        }.compact.flatten.uniq if child_platforms && child_platforms.size > 0
        child_stop_times.each { |st| puts "########## The next #{st.subway_route.route_short_name} train in the #{st.trip.direction_id} direction will depart at #{st.departure_time}" } if child_stop_times

        # narrow down to valid trains (don't take a train that will duplicate a previously found trip)
        valid_child_stop_times = child_stop_times.select{ |child_stop_time|
          next_stop_time = child_stop_time.next_stop
          !self.class.possible_trips.include?(stops_visited.dup.push(next_stop_time.stop.parent_station))
        } if child_stop_times && child_stop_times.size > 0

        # do the magic on valid trains
        if valid_child_stop_times && valid_child_stop_times.size > 0
          valid_child_stop_times.each { |child_stop_time|
            child_stop_time.stop.traverse_stops(child_stop_time.subway_route, current_time, max_stops, stops_visited.dup)
          }
        else
          puts "########## No more valid trains; breaking"
          break
        end
      end
      puts "########## If no previous message, the max number of stops was reached" 
      puts "########## Stops visited were #{stops_visited}"
    else 
      puts "########## No more valid stops (very likely, the next stop was already visited; this is not likely to trigger due to 'no stop' because a departing train doesn't make sense without a stop)"
    end 
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

  def next_departing_train(route, datetime)
    stop_times.next_departing_train(self, route, datetime)
  end   
end