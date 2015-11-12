class Api::V1::VehiclesController < ApiController

  def index
    account_vehicles = Location.find_by(name: params["account"]).vehicles
    respond_with account_vehicles, location: root_url
  end

  def create
    location = Location.find_by(name: params["account"])
    new_vehicle = location.vehicles.create(ticket_no: params["ticketNo"], space: params["space"])
    respond_with new_vehicle, location: root_url
  end

end
