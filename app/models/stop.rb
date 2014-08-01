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
    self.class.possible_trips.uniq
  end 

  def traverse_stops(starting_route, starting_time, max_stops, stops_visited=[])
    # setup state
    puts "########## Setting initial variables"
    current_platform = self
    current_time = starting_time
    puts "########## The current platform is #{current_platform.stop_name}, and the time is #{starting_time}"
    current_stop_time = current_platform.next_departing_train(starting_route, current_time)
    puts "########## The next departing train on the #{current_stop_time.subway_route.route_short_name} line will leave at #{current_stop_time.departure_time}"

    # check if the next stop exists, and is a valid stop
    next_stop_time = current_stop_time.trip.stop_times.select { |st| 
      st.stop_sequence == current_stop_time.stop_sequence+1
    }[0]
    puts "########## The next stop on the #{next_stop_time.subway_route.route_short_name} line is #{next_stop_time.stop.stop_name}" if next_stop_time

    if next_stop_time && !stops_visited.include?(next_stop_time.stop.parent_station)
      # move to that stop
      current_platform = next_stop_time.stop
      current_time = Time.parse(next_stop_time.arrival_time.adjust_mod_24)
      current_stop_time = next_stop_time
      puts "########## Moved to the next stop. The time is #{current_time}"

      # record movement
      stops_visited << current_platform.parent_station
      self.class.possible_trips << stops_visited
      puts "########## Stops_visited are #{stops_visited} and possible_trips are #{self.class.possible_trips}"

      # check if we need to make any more stops
      while stops_visited.size < max_stops
        # check for transfers
        parent_station = Stop.find(current_platform.parent_station)
        transfers = parent_station.from_transfers

        if transfers.size > 0
          puts "########## The current platform is #{current_platform.stop_name}, and the time is #{starting_time}"
          puts "########## Stops_visited are #{stops_visited} and possible_trips are #{self.class.possible_trips}"
          puts "########## #{transfers.size} transfers exist from #{current_platform.stop_name}"

          # narrow down to valid transfers
          child_platforms = transfers.collect { |t| 
            Stop.where("parent_station = ?", t.to_stop_id)
          }.compact.flatten.reject{ |s|
            s.parent_station == current_platform.parent_station && s != current_platform
          }
          child_platforms.each { |s| puts "########## You can transfer from #{current_platform.stop_id} to #{s.stop_id}" }

          if child_platforms.size > 0
            child_stop_times = child_platforms.collect { |platform|
              routes = platform.subway_routes.uniq
              routes.collect { |route|
                platform.next_departing_train(route, current_time)
              }.uniq
            }.compact.flatten.uniq
            child_stop_times.each { |st| puts "########## On the #{st.stop_id} platform, the next departing #{st.subway_route.route_short_name} train will arrive at #{st.arrival_time}"}

            if child_stop_times.size > 0
              valid_child_stop_times = child_stop_times.select{ |child_stop_time|
                next_stop_time = current_stop_time.trip.stop_times.select { |st| 
                  st.stop_sequence == current_stop_time.stop_sequence+1
                }[0]
                !self.class.possible_trips.include?(stops_visited.dup.push(next_stop_time.stop.parent_station))
              }

              # for each valid transfer, start over again with the starting platform set to the transfer platform
              if valid_child_stop_times.size > 0
                valid_child_stop_times.each { |child_stop_time|
                  child_stop_time.stop.traverse_stops(child_stop_time.subway_route, current_time, max_stops, stops_visited.dup)
                }
              else
                break
              end 
            else
              break
            end
          else
            break        
          end
        else
          break        
        end
      end
      puts "########## Broke out of the loop; maybe the max number of stops was reached; the sequence for this trip is #{stops_visited}" 
    else 
      puts "########## There are no more stops"
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