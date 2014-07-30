class Transfer < ActiveRecord::Base
  belongs_to :from_stop, class_name: "Stop", foreign_key: "from_stop_id"
  belongs_to :to_stop, class_name: "Stop", foreign_key: "to_stop_id"
end 