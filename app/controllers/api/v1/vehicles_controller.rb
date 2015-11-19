class Api::V1::VehiclesController < ApiController

  def index
    respond_with Location.find_by(name: params["account"]).vehicles, location: root_url
  end

  def create
    respond_with Vehicle.create_by_location(params), location: root_url
  end

  def pull_up
    respond_with Vehicle.pull_up(params), location: root_url
  end

  def give_quote
    respond_with Vehicle.give_quote(params), location: root_url
  end

  def return
    respond_with Vehicle.return(params), location: root_url
  end

end
