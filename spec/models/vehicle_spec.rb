require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:vehicle) { build(:vehicle) }

  it "is valid with correct attributes" do
    expect(vehicle.save).to be true
    expect(vehicle).to be_valid
  end

  it "must have a valid 3 digit ticket_no" do
    vehicle.ticket_no = nil
    expect(vehicle.save).to be false

    vehicle.ticket_no = 1234
    expect(vehicle.save).to be false

    vehicle.ticket_no = 123
    expect(vehicle.save).to be true
    expect(vehicle).to be_valid
  end

  it "must have a space" do
    vehicle.space = nil
    expect(vehicle.save).to be false

    vehicle.space = "anything"
    expect(vehicle.save).to be true
  end

  it "has a default status of parked" do
    vehicle.status = nil
    vehicle.save
    expect(vehicle.status).to match("parked")
  end

  it "creates a vehicle by location" do
    create(:location)
    params = { "account" => "Chloe",
	       "ticketNo" => 101,
	       "space" => "g1",
	       "color" => "Red",
	       "style" => "Coupe"
             }

    vehicle = Vehicle.create_by_location(params)
    expect(vehicle.location.name).to match("Chloe")
  end

  it "has a pull up method that changes status to 'transit'" do
    vehicle.save
    params = { "id" => 7 }
    vehicle = Vehicle.pull_up(params)
   
    expect(vehicle.status).to match("transit")
  end

  it "gives a customer a time quote" do
    vehicle = create(:vehicle)
    create(:customer)
    params = { "id" => vehicle.id, "ticket" => 101, "quote" => "5" }
    response = Vehicle.give_quote(params)
    
    expect(response[:vehicle].id).to match(vehicle.id)
    expect(response[:quote]).to match("5")
  end

  it "returns a vehicle" do
    vehicle = create(:vehicle)
    params = { "id" => vehicle.id }
    vehicle = Vehicle.return(params)

    expect(vehicle.status).to match("returned")
  end

end
