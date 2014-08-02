class RenameParentStopToParentStation < ActiveRecord::Migration
  def change
    rename_column :queries, :parent_stop_id1, :parent_station_id1
    rename_column :queries, :parent_stop_id2, :parent_station_id2
  end
end
