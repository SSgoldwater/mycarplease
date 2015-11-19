class Vehicle < ActiveRecord::Base
  belongs_to :location
  belongs_to :customer
  validates :ticket_no, length: { is: 3 }
  validates :space, presence: true
  before_save :default_values
  
  def default_values
    self.status ||= "parked"
  end

  def self.create_by_location(params)
    location = Location.find_by(name: params["account"])
    new_vehicle = location.vehicles.create(ticket_no: params["ticketNo"], 
					   space: params["space"], 
					   color: params["color"],
					   style: params["style"],
					   status: "parked"
					  )
  end

  def self.pull_up(params)
    vehicle = Vehicle.find(params["id"])
    vehicle.status = "transit"
    vehicle.save!
    vehicle
  end

  def self.give_quote(params)
    vehicle = Vehicle.find(params["id"])
    customer = Customer.find_by(ticket_no: params["ticket"])
    customer.send_quote(params["quote"])
    vehicle.status = "transit"
    vehicle.save!
    response = { vehicle: vehicle, quote: params["quote"] } 
  end

  def self.return(params)
    vehicle = Vehicle.find(params["id"])
    vehicle.status = "returned"
    vehicle.save
    vehicle
  end

end
