class Vehicle < ActiveRecord::Base
  belongs_to :location
  belongs_to :customer
end
