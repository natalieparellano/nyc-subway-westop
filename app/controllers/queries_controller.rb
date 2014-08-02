class QueriesController < ApplicationController

  def new
    @parent_stations1 = []
    @stops1 = []
    @parent_stations2 = []
    @stops2 = []
  end 

  def create
    @query = Query.find_or_create_by(query_params)
    @query.results = @query.take_inputs_from_user
    @query.save
  end 

  # for updating the dropdown selects
  def update_parent_stations1
    subway_route1 = SubwayRoute.find(params[:route_id])
    @parent_stations1 = subway_route1.parent_stations
  end 

  def update_headsigns1
    parent_station1 = Stop.find(params[:parent_station_id])
    @stops1 = Stop.child_stations(parent_station1)
  end

  def update_parent_stations2
    subway_route2 = SubwayRoute.find(params[:route_id])
    @parent_stations2 = subway_route2.parent_stations
  end 

  def update_headsigns2
    parent_station2 = Stop.find(params[:parent_station_id])
    @stops2 = Stop.child_stations(parent_station2)
  end 

  private

    def query_params
      params.require(:query).permit(
        :route_id1, :route_id2, 
        :stop_id1, :stop_id2,
        :max_stops1, :max_stops2
      )
    end 
end