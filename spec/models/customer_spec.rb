require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { create(:customer) }

  context "with correct attributes" do
    it "is valid" do
      expect(customer).to be_valid
    end
  end
 
  it "must have a 10 digit phone number on creation" do
    customer.phone = 123456789
    expect(customer.save).to be false

    customer.phone = nil
    expect(customer.save).to be false

    customer.phone = 1234567890
    expect(customer.save).to be true
  end

  it "has a send_code method that sends a successful twilio code" do
    sms = customer.send_code(customer.phone)
    expect(sms.body).to include("confirmation number")
  end
  
  it "has a send_quote method that sends a message with quote time" do
    sms = customer.send_quote(10)
    expect(sms.body).to include("Your vehicle will be ready in 10 minutes.")
  end

  it "has a verify method that verifies the customer by text confirmation" do
    vehicle = create(:vehicle)
    create(:location)
    params = { "customer" => { "location" => 1 , "ticket_no" => 101 } }
    customer_params = { text_confirmation: "1234" } 

    expect(customer.verify(customer, params, customer_params)).to match(:final)

    customer_params = { text_confirmation: "1111" } 
    expect(customer.verify(customer, params, customer_params)).to match(:get_vehicle)   
  end
	       
  
    

end

