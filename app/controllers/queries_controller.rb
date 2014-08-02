class QueriesController < ApplicationController

  def new
    @parent_stations1 = []
  end 

  def create
  end 

  def update_parent_stations1
    subway_route1 = SubwayRoute.find(params[:route_id])
    @parent_stations1 = subway_route1.parent_stations
  end 
end