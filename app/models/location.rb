class Location < ActiveRecord::Base
  has_many :vehicles
  has_many :employees
  validates :name, presence: true
end
