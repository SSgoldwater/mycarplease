require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create (:employee) }

  it "is valid with correct attributes" do
    expect(employee.save).to be true
  end

  it "is created with a status of inactive" do
    employee.status = nil
    employee.save
    expect(employee.status).to match("inactive")
  end
   
  it "must have a first name" do
    employee.first_name = nil
    expect(employee.save).to be false
  end

  it "must have a last name" do
    employee.last_name = nil
    expect(employee.save).to be false
  end

  it "must have an email" do
    employee.email = nil
    expect(employee.save).to be false
  end

  it "must have a password" do
    employee.password = nil
    expect(employee.save).to be false
  end

  it "can clock in" do
    create(:location)
    params = { "password" => "password", "account" => "Chloe" }
    response = employee.clockin(employee, params)

    expect(response.length).to eq(3)
    
    params = { "password" => "wrong", "account" => "Chloe" }
    response = employee.clockin(employee, params)

    expect(response.length).to eq(1)
  end

end
