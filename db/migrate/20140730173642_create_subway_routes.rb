class CreateSubwayRoutes < ActiveRecord::Migration
  def change
    create_table :subway_routes do |t|

      t.timestamps
    end
  end
end
