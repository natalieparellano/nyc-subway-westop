time_now = Time.parse('2014-07-31 07:24:58 -0700')

a_train = SubwayRoute.find("A")
a_train_northbound = Trip.find("B20140608WKD_041000_A..S54R")
a_train_southbound = Trip.find("B20140608WKD_041050_A..N54R")

chambers_south = Stop.find("A36S")
chambers_north = Stop.find("A36N")
chambers_parent = Stop.find("A36")
penn_station_north = Stop.find("A28N")
penn_station_south = Stop.find("A28S")

times_square_a_north = Stop.find("A27N")

chambers_next_departing_south = Trip.find("B20140608WKD_041000_A..S54R").
  stop_times.select { |st| 
    st.stop_sequence == 15 
  }[0]
chambers_next_departing_north = Trip.find("B20140608WKD_041050_A..N54R").
  stop_times.select { |st| 
    st.stop_sequence == 16 
  }[0]

# chambers_north.find_possible_trips(a_train, Time.now, 3)
# penn_station_south.find_possible_trips(SubwayRoute.find("A"), Time.now, 3)

arr1 = [
  ["A31"],
  ["A31", "A32"],
  ["A31", "A32", "A34"],
  ["A31", "A32", "A33"],
  ["A31", "A32", "D17"],
  ["A31", "A32", "D19"],
  ["A31", "A32", "D21"],
  ["A31", "L02"],
  ["A31", "L02", "131"],
  ["A31", "L02", "128"],
  ["A31", "L02", "137"],
  ["A31", "L02", "133"],
  ["A31", "L02", "D18"],
  ["A31", "L02", "D20"],
  ["A31", "L02", "L03"]
]

arr2 = [
  ["A34"],
  ["A34", "A33"],
  ["A34", "A33", "A32"],
  ["A34", "A32"],
  ["A34", "A32", "A31"],
  ["A34", "A32", "D17"],
  ["A34", "A32", "D19"],
  ["A34", "A32", "D21"]
]

Stop.find_common_stops(arr1, arr2, 4)