require 'rails_helper'

RSpec.describe "User Flow", type: :feature do

  scenario "customer sees homepage" do
    visit root_path

    expect(page).to have_content("Getting your vehicle")
  end

  xscenario "customer enters phone number" do
    visit root_path
    
    click_button "\"Please\"" 
    expect(page).to have_content("Your mobile phone number:")
    
    fill_in "customer_phone", with: "+14196997844"
    click_button "Last Step"
    save_and_open_page
  end

end
