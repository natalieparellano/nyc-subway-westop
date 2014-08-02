class Query < ActiveRecord::Base
  serialize :results

  def take_inputs_from_user
    stop1 = Stop.find(self.stop_id1)
    stop2 = Stop.find(self.stop_id2)
    route1 = SubwayRoute.find(self.route_id1)
    route2 = SubwayRoute.find(self.route_id2)
    num_stops1 = self.max_stops1
    num_stops2 = self.max_stops2

    arr1 = stop1.find_possible_trips(route1, Time.now, num_stops1)
    arr2 = stop2.find_possible_trips(route2, Time.now, num_stops2)

    find_common_stops(arr1, arr2, 4)
  end 

  def results_in_words
    results.collect { |pair|
      pair.collect { |sequence|
        sequence.collect { |leg|
          "Take the #{leg[1]} to #{Stop.find(leg[0]).stop_name}"
        }
      }
    }
  end 

  # once we have all possible stops, we need to find all pairs of stops for which the difference in latitude and longitude is small
  def find_common_stops(arr1, arr2, num_seqs)
    # for each array,
    last_stops_arr1, last_stops_arr2 = [arr1, arr2].collect { |arr|
      arr.collect { |sequence|
        last_stop = Stop.find(sequence.last[0])
      }
    }

    common_stops = last_stops_arr1.collect { |arr1_stop|
      last_stops_arr2.collect { |arr2_stop|
        [arr1_stop, arr2_stop] if (arr1_stop.stop_lat - arr2_stop.stop_lat).abs < 0.0035 &&
          (arr1_stop.stop_lon - arr2_stop.stop_lon).abs < 0.0035
      }.compact
    }.uniq.reject { |arr| arr.size == 0}

    if common_stops.size > 0
      best_sequences = common_stops.collect { |stop_pair|

        # choose the shortest sequence that gets you to the common stop
        arr1_stop = stop_pair.flatten[0]
        arr1_shortest_sequence = arr1.select { |sequence|
          sequence[-1][0] == arr1_stop.stop_id
        }.sort_by(&:length)[0]

        # choose the shortest sequence that gets you to the common stop
        arr2_stop = stop_pair.flatten[1]
        arr2_shortest_sequence = arr2.select { |sequence|
          sequence[-1][0] == arr2_stop.stop_id
        }.sort_by(&:length)[0]

        [arr1_shortest_sequence, arr2_shortest_sequence]
      }.reject { |arr| arr.size == 0}

      # for each pair of sequences, determine how equal they are
      ranked_indexes = best_sequences.collect.with_index { |sequence, i|
        arr1_size = sequence[0].size
        arr2_size = sequence[1].size
        tot_size = arr1_size + arr2_size
        avg_size = (arr1_size + arr2_size) / 2.0
        equality = (arr1_size - avg_size).abs + (arr2_size - avg_size).abs / 2.0

        [i, equality, tot_size]
      }

      # sort by equality
      sorted_indexes = ranked_indexes.sort do |a,b|
        comp = (a[1] <=> b[1])
        comp.zero? ? (a[2] <=> b[2]) : comp
      end

      # return only a subset of sequences
      indexes_to_return = sorted_indexes[0..num_seqs-1].collect { |arr|
        arr[0]
      }

      indexes_to_return.collect { |i|
        best_sequences[i]
      }
    else
      []
    end 
  end
end