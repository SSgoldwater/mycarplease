require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { create (:location) }

  it "is valid with correct attributes" do
    expect(location.save).to be true
    expect(location).to be_valid
  end

  it "is invalid without a name" do
    location.name = nil
    expect(location.save).to be false
  end

end
