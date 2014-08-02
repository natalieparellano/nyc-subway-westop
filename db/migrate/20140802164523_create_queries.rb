class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :route_id1, :route_id2, :parent_stop_id1, :parent_stop_id2, :stop_id1, :stop_id2
      t.integer :max_stops1, :max_stops2

      t.timestamps
    end
  end
end