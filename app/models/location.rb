class Location < ActiveRecord::Base
  has_many :vehicles
  has_many :employees
end
