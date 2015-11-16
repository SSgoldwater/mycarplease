require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:vehicle) { create(:vehicle) }

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

end
