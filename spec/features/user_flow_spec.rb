require 'rails_helper'

RSpec.describe "User Flow", type: :feature do

  scenario "customer sees homepage" do
    visit root_path

    expect(page).to have_content("Getting your vehicle")
  end

end
