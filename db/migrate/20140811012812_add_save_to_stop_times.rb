class AddSaveToStopTimes < ActiveRecord::Migration
  def change
    add_column :stop_times, :save_this_record, :boolean, default: false
  end
end
