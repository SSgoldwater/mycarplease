class Api::V1::VehiclesController < ApiController

  def index
    account_vehicles = Location.find_by(name: params["account"]).vehicles
    respond_with account_vehicles, location: root_url
  end

  def create
    location = Location.find_by(name: params["account"])
    new_vehicle = location.vehicles.create(ticket_no: params["ticketNo"], 
					   space: params["space"], 
					   color: params["color"],
					   style: params["style"],
					   status: "parked"
					  )
    respond_with new_vehicle, location: root_url
  end

  def pull_up
    vehicle = Vehicle.find(params["id"])
    vehicle.status = "transit"
    vehicle.save

    respond_with vehicle, location: root_url
  end

  def give_quote
    vehicle = Vehicle.find(params["id"])
    customer = Customer.find_by(ticket_no: params["ticket"])
    customer.send_quote(params["quote"])
    vehicle.status = "transit"
    vehicle.save
    response = { vehicle: vehicle, quote: params["quote"] } 

    respond_with response, location: root_url
  end

  def return
    vehicle = Vehicle.find(params["id"])
    vehicle.status = "returned"
    vehicle.save

    respond_with vehicle, location: root_url
  end

end
