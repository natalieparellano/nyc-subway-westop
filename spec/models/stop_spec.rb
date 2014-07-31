require 'rails_helper'
require 'pry'

# rspec won't work since the db needs to be populated with existing data

  time_now = Time.parse('2014-07-31 07:24:58 -0700')

  a_train = SubwayRoute.find("A")
  a_train_northbound = Trip.find("B20140608WKD_041000_A..S54R")
  a_train_southbound = Trip.find("B20140608WKD_041050_A..N54R")

  chambers_south = Stop.find("A36S")
  chambers_north = Stop.find("A36N")
  
  chambers_next_departing_south = Trip.find("B20140608WKD_041000_A..S54R").
    stop_times.select { |st| 
      st.stop_sequence == 15 
    }[0]
  chambers_next_departing_north = Trip.find("B20140608WKD_041050_A..N54R").
    stop_times.select { |st| 
      st.stop_sequence == 16 
    }[0]