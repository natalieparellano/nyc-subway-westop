class Stop < ActiveRecord::Base
  self.primary_key = 'stop_id'
  has_many :stop_times

  has_many :trips, through: :stop_times
  has_many :subway_routes, through: :trips # duplication

  has_many :to_transfers, foreign_key: "to_stop_id", class_name: "Transfer"
  has_many :from_transfers, foreign_key: "from_stop_id", class_name: "Transfer"

  has_many :users

  # Game plan
  # just pick one direction to start with

  # given a stop and a route (and maybe a time)
  # and another stop and route (and maybe a time)

  # do this... 

  # for that trip, we want to traverse the stops 
  def traverse_stops(starting_route, starting_time, max_stops, stops_visited=[], possible_trips=[])

    puts "########## Setting initial variables"

    current_platform = self
    puts "########## The current stop is #{current_platform.stop_name}, and the time is #{starting_time}"

    current_time = starting_time
    current_stop_time = current_platform.next_departing_train(starting_route, current_time)
    
    while stops_visited.size < max_stops
      possible_trips << stops_visited
      stops_visited << current_platform.parent_station
      puts "########## stops_visited are #{stops_visited} and possible_trips are #{possible_trips}"

      next_stop_time = current_stop_time.trip.stop_times.select { |st| 
        st.stop_sequence == current_stop_time.stop_sequence+1
      }[0]
      puts "########## The next stop on the #{next_stop_time.subway_route.route_short_name} line is #{next_stop_time.stop.stop_name}" if next_stop_time

      if next_stop_time && !stops_visited.include?(next_stop_time.stop.parent_station)
        current_platform = next_stop_time.stop
        current_time = Time.parse(next_stop_time.arrival_time)
        current_stop_time = next_stop_time
        puts "########## Moved to the next stop. The time is #{current_time}"
      else 
        puts "There are no more stops"
        break  
      end

      # after the first stop, check for transfers:
      parent_station = Stop.find(current_platform.parent_station)
      transfers = parent_station.from_transfers

      if transfers.size > 0
        puts "Transfers exist"
        child_platforms = transfers.collect { |t| 
          puts "########## You can transfer from #{t.from_stop.stop_id} to #{t.to_stop.stop_id}"
          Stop.where("parent_station = ?", t.to_stop_id)
        }.compact.flatten
        .reject{ |s|
          stops_visited.include?(s.parent_station) && s != current_platform
        }

        if child_platforms.size > 0
          child_stop_times = child_platforms.collect { |platform|
            puts "########## On the #{platform.stop_id} platform, checking routes"
            routes = platform.subway_routes.uniq
            routes.collect { |route|
              puts "########## Finding the next departing #{route.route_short_name} train on the #{platform.stop_id} platform"
              next_train = platform.next_departing_train(route, current_time+120)
              puts "########## Traversing stops for that route"
              next_train.stop.traverse_stops(next_train.subway_route, current_time, max_stops, stops_visited.dup, possible_trips) if next_train
            }
          }.compact         
        end        
      end  
    end

    puts "Max number of stops reached, the sequence for this trip is #{stops_visited}"
    return possible_trips
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