locations = Location.create([
  { name: "Chloe" }, 
  { name: "Epernay" }, 
  { name: "Viewhouse" }
])

employees = Employee.create([
  { first_name: "Stanley", last_name: "Ski",   email: "ss@abc.com", password: "pass", status: "inactive" },
  { first_name: "Nate",    last_name: "Van",   email: "nv@abc.com", password: "pass", status: "inactive" },
  { first_name: "Jack",    last_name: "Eigel", email: "je@abc.com", password: "pass", status: "inactive" }
])

locations.first.vehicles = Vehicle.create([
  { color: "Red", style: "Coupe", ticket_no: 101, space: "G27", status: "parked" },
  { color: "Grey", style: "Convertible", ticket_no: 102, space: "4", status: "parked" },
  { color: "Black", style: "Van", ticket_no: 103, space: "rocks", status: "parked" }, 
  { color: "Red", style: "Sedan", ticket_no: 107, space: "7", status: "parked" },
]) 

locations[1].vehicles = Vehicle.create([
  { color: "Black", style: "Truck", ticket_no: 233, space: "vip", status: "parked" },
  { color: "White", style: "Sedan", ticket_no: 237, space: "3B7", status: "parked" },
]) 
 
locations[2].vehicles = Vehicle.create([
  { color: "Yellow", style: "Sedan", ticket_no: 232, space: "D1", status: "parked"},
  { color: "Orange", style: "Van", ticket_no: 231, space: "A4", status: "parked"},
  { color: "Blue", style: "Suv", ticket_no: 521, space: "A8", status: "parked" },
  { color: "Green", style: "Sedan", ticket_no: 522, space: "C4", status: "parked" },
  { color: "Yellow", style: "Coupe", ticket_no: 523, space: "tB3", status: "parked" },
  { color: "Silver", style: "Sedan", ticket_no: 528, space: "B1", status: "parked" },
  { color: "Green", style: "Truck", ticket_no: 529, space: "B5", status: "parked" },
]) 
