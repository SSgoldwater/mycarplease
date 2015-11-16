FactoryGirl.define do

  factory :customer do
    phone "4196997844"
    name "John"
    ticket_no 101
    text_confirmation 1234
    location_id 1 
  end

  factory :employee do
    first_name "Stanley"
    last_name "Ski"
    email "stanley@gmail.com"
    password "password"
    status "inactive"
  end 
  
  factory :location do
    name "Chloe" 
  end
   
  factory :vehicle do
    color "red"
    style "sedan"
    ticket_no 101
    space "G15"
    location_id 1
    status "parked"
  end 

end
