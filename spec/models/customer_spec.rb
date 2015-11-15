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

end

