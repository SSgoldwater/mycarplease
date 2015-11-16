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
  { color: "red", style: "coupe", ticket_no: 101, space: "G27", status: "parked" },
  { color: "grey", style: "convertible", ticket_no: 102, space: "4", status: "parked" },
  { color: "black", style: "van", ticket_no: 103, space: "rocks", status: "parked" }, 
  { color: "red", style: "sedan", ticket_no: 107, space: "7", status: "parked" },
]) 

locations[1].vehicles = Vehicle.create([
  { color: "orange", style: "van", ticket_no: 231, space: "3A4", status: "parked"},
  { color: "yellow", style: "sedan", ticket_no: 232, space: "4B12", status: "parked"},
  { color: "pink", style: "truck", ticket_no: 233, space: "vip", status: "parked" },
  { color: "white", style: "sedan", ticket_no: 237, space: "3B7", status: "parked" },
]) 
 
locations[2].vehicles = Vehicle.create([
  { color: "blue", style: "suv", ticket_no: 521, space: "A8", status: "parked" },
  { color: "green", style: "sedan", ticket_no: 522, space: "C4", status: "parked" },
  { color: "yellow", style: "coupe", ticket_no: 523, space: "tB3", status: "parked" },
  { color: "silver", style: "sedan", ticket_no: 528, space: "B1", status: "parked" },
  { color: "green", style: "truck", ticket_no: 529, space: "B5", status: "parked" },
]) 
