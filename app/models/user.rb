class User < ActiveRecord::Base
  belongs_to :stop

  has_many :stop_times, through: :stop
  has_many :to_transfers, through: :stop
  has_many :from_transfers, through: :stop

  has_many :trips, through: :stop_times
  has_many :subway_routes, through: :trips # duplication
end