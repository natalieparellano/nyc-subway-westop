# time_now = Time.parse('2014-07-31 07:24:58 -0700')

a_train = SubwayRoute.find("A")
# a_train_northbound = Trip.find("B20140608WKD_041000_A..S54R")
# a_train_southbound = Trip.find("B20140608WKD_041050_A..N54R")
l_train = SubwayRoute.find("L")

chambers_south = Stop.find("A36S")
chambers_north = Stop.find("A36N")
chambers = Stop.find("A36")
# penn_station_north = Stop.find("A28N")
# penn_station_south = Stop.find("A28S")
# times_square_a_north = Stop.find("A27N")
bedford_man = Stop.find("L08N")

q = Query.new
q.take_inputs_from_user(chambers_north, bedford_man, a_train, l_train, 4, 5)

# chambers_next_departing_south = Trip.find("B20140608WKD_041000_A..S54R").
#   stop_times.select { |st| 
#     st.stop_sequence == 15 
#   }[0]
# chambers_next_departing_north = Trip.find("B20140608WKD_041050_A..N54R").
#   stop_times.select { |st| 
#     st.stop_sequence == 16 
#   }[0]

chambers_north.find_possible_trips(a_train, Time.now, 4)
bedford_man.find_possible_trips(l_train, Time.now, 5)

arr1 = [
  [["A34", "A"]],
  [["A34", "A"], ["A33", "E"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["A31", "E"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["A31", "A"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["A31", "C"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D17", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D19", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D19", "M"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D17", "B"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D21", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D21", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D21", "B"]],
  [["A34", "A"], ["A33", "E"], ["A32", "E"], ["D21", "M"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["A31", "E"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["A31", "A"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["A31", "C"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D17", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D19", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D19", "M"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D21", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D21", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "A"], ["D21", "M"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["A31", "E"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["A31", "A"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["A31", "C"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D17", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D19", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D19", "M"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D17", "B"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D21", "D"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D21", "F"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D21", "B"]],
  [["A34", "A"], ["A33", "E"], ["A32", "C"], ["D21", "M"]],
  [["A34", "A"], ["A32", "A"]],
  [["A34", "A"], ["A32", "A"], ["A31", "E"]],
  [["A34", "A"], ["A32", "A"], ["A31", "E"], ["A30", "E"]],
  [["A34", "A"], ["A32", "A"], ["A31", "E"], ["A28", "A"]],
  [["A34", "A"], ["A32", "A"], ["A31", "E"], ["A30", "C"]],
  [["A34", "A"], ["A32", "A"], ["A31", "E"], ["L02", "L"]],
  [["A34", "A"], ["A32", "A"], ["A31", "A"]],
  [["A34", "A"], ["A32", "A"], ["A31", "A"], ["A30", "E"]],
  [["A34", "A"], ["A32", "A"], ["A31", "A"], ["A28", "A"]],
  [["A34", "A"], ["A32", "A"], ["A31", "A"], ["A30", "C"]],
  [["A34", "A"], ["A32", "A"], ["A31", "A"], ["L02", "L"]],
  [["A34", "A"], ["A32", "A"], ["A31", "C"]],
  [["A34", "A"], ["A32", "A"], ["A31", "C"], ["A30", "E"]],
  [["A34", "A"], ["A32", "A"], ["A31", "C"], ["A28", "A"]],
  [["A34", "A"], ["A32", "A"], ["A31", "C"], ["A30", "C"]],
  [["A34", "A"], ["A32", "A"], ["A31", "C"], ["L02", "L"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["D16", "D"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["D16", "F"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["D16", "M"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["D16", "B"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R16", "Q"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R16", "N"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R16", "R"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R18", "N"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R20", "Q"]],
  [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R18", "R"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["131", "1"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["128", "2"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["128", "3"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["137", "2"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["133", "1"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["137", "3"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["D18", "F"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["D18", "M"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["L01", "L"]],
  [["A34", "A"], ["A32", "A"], ["D19", "F"], ["L03", "L"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["131", "1"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["128", "2"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["128", "3"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["137", "2"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["133", "1"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["137", "3"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["D18", "F"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["D18", "M"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["L01", "L"]],
  [["A34", "A"], ["A32", "A"], ["D19", "M"], ["L03", "L"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["D16", "D"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["D16", "F"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["D16", "M"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["D16", "B"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R16", "Q"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R16", "N"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R16", "R"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R18", "N"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R20", "Q"]],
  [["A34", "A"], ["A32", "A"], ["D17", "B"], ["R18", "R"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["636", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["636", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["636", "6X"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["638", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["638", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["D22", "D"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["F14", "F"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["D22", "B"]],
  [["A34", "A"], ["A32", "A"], ["D21", "D"], ["M18", "M"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["636", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["636", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["636", "6X"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["638", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["638", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["D22", "D"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["F14", "F"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["D22", "B"]],
  [["A34", "A"], ["A32", "A"], ["D21", "F"], ["M18", "M"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["636", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["636", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["636", "6X"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["638", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["638", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["D22", "D"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["F14", "F"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["D22", "B"]],
  [["A34", "A"], ["A32", "A"], ["D21", "B"], ["M18", "M"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["636", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["636", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["636", "6X"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["638", "6"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["638", "4"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["D22", "D"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["F14", "F"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["D22", "B"]],
  [["A34", "A"], ["A32", "A"], ["D21", "M"], ["M18", "M"]],
  [["A34", "A"], ["A33", "C"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["A31", "E"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["A31", "A"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["A31", "C"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D17", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D19", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D19", "M"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D17", "B"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D21", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D21", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D21", "B"]],
  [["A34", "A"], ["A33", "C"], ["A32", "E"], ["D21", "M"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["A31", "E"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["A31", "A"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["A31", "C"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D17", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D19", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D19", "M"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D21", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D21", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "A"], ["D21", "M"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["A31", "E"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["A31", "A"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["A31", "C"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D17", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D19", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D19", "M"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D17", "B"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D21", "D"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D21", "F"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D21", "B"]],
  [["A34", "A"], ["A33", "C"], ["A32", "C"], ["D21", "M"]]
]

arr2 = [
  [["L06", "L"]],
  [["L06", "L"], ["L05", "L"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6"], ["633", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6"], ["633", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6"], ["633", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["630", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["629", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["629", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["630", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["721", "7"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["721", "7X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["724", "7"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "4"], ["902", "S"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["630", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["629", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["629", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["630", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["721", "7"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["721", "7X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["724", "7"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["631", "5"], ["902", "S"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6X"], ["633", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6X"], ["633", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["634", "6X"], ["633", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"], ["418", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"], ["418", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"], ["M20", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"], ["M20", "Z"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "4"], ["M22", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["636", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["636", "6"], ["637", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["636", "6"], ["637", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"], ["418", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"], ["418", "5"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"], ["M20", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"], ["M20", "Z"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["640", "5"], ["M22", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["131", "1"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["128", "2"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["128", "3"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["137", "2"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["133", "1"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["137", "3"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["D18", "F"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["D18", "M"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["D20", "F"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["D20", "M"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"], ["L01", "L"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D16", "D"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D16", "F"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D16", "M"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D16", "B"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D20", "D"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D18", "F"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D20", "B"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["D18", "M"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["R16", "Q"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["R16", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R17", "Q"], ["R16", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "N"], ["R18", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "N"], ["R18", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "R"], ["R18", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R19", "R"], ["R18", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "N"], ["R22", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "N"], ["R22", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["638", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["638", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["638", "6X"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["640", "6"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["640", "4"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["M19", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["M19", "Z"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["M21", "J"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["R31", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["R30", "Q"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["R30", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["R22", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["Q01", "Q"], ["R24", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "R"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "R"], ["R22", "N"]],
  [["L06", "L"], ["L05", "L"], ["L03", "L"], ["R21", "R"], ["R22", "R"]]
]

Stop.find_common_stops(arr1, arr2, 4)

results = [
  [
    [["A34", "A"], ["A32", "A"], ["D21", "D"], ["636", "6"]], 
    [["L06", "L"], ["L05", "L"], ["L03", "L"], ["636", "6"]]
  ],
  [
    [["A34", "A"], ["A32", "A"], ["A31", "E"], ["L02", "L"]], 
    [["L06", "L"], ["L05", "L"], ["L03", "L"], ["L02", "L"]]
  ],
  [
    [["A34", "A"], ["A32", "A"], ["D17", "D"], ["R20", "Q"]], 
    [["L06", "L"], ["L05", "L"], ["L03", "L"]]
  ],
  [
    [["A34", "A"], ["A32", "A"], ["D19", "M"]], [["L06", "L"], 
    ["L05", "L"], ["L03", "L"], ["L02", "L"]]
  ]
]

results.collect { |pair|
  pair.collect { |sequence|
    sequence.collect { |leg|
      "Take the #{leg[1]} to #{Stop.find(leg[0]).stop_name}"
    }
  }
}

results_in_words = [
  [
    ["Take the A to Canal St", "Take the A to W 4 St", "Take the D to Broadway-Lafayette St", "Take the 6 to Astor Pl"],
    ["Take the L to 1 Av", "Take the L to 3 Av", "Take the L to Union Sq - 14 St", "Take the 6 to Astor Pl"]
  ],
  [
    ["Take the A to Canal St", "Take the A to W 4 St", "Take the E to 14 St", "Take the L to 6 Av"],
    ["Take the L to 1 Av", "Take the L to 3 Av", "Take the L to Union Sq - 14 St", "Take the L to 6 Av"]
  ],
  [
    ["Take the A to Canal St", "Take the A to W 4 St", "Take the D to 34 St - Herald Sq", "Take the Q to 14 St - Union Sq"],
    ["Take the L to 1 Av", "Take the L to 3 Av", "Take the L to Union Sq - 14 St"]
  ],
  [
    ["Take the A to Canal St", "Take the A to W 4 St", "Take the M to 14 St"],
    ["Take the L to 1 Av", "Take the L to 3 Av", "Take the L to Union Sq - 14 St", "Take the L to 6 Av"]
  ]
]