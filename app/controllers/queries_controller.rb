class QueriesController < ApplicationController

  def new
    @parent_stations1 = []
    @stops1 = []
  end 

  def create
    raise params.inspect
  end 

  def update_parent_stations1
    subway_route1 = SubwayRoute.find(params[:route_id])
    @parent_stations1 = subway_route1.parent_stations
  end 

  def update_headsigns1
    parent_station1 = Stop.find(params[:parent_station_id])
    @stops1 = Stop.child_stations(parent_station1)
  end 
end