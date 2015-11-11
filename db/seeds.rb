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
  { color: "red", style: "coupe", ticket_no: 101, space: "G27" },
  { color: "grey", style: "sedan", ticket_no: 102, space: "4" },
  { color: "black", style: "truck", ticket_no: 103, space: "rocks" }, 
  { color: "red", style: "sedan", ticket_no: 107, space: "7" },
]) 

locations[1].vehicles = Vehicle.create([
  { color: "orange", style: "coupe", ticket_no: 231, space: "3A4" },
  { color: "yellow", style: "sedan", ticket_no: 232, space: "4B12" },
  { color: "pink", style: "truck", ticket_no: 233, space: "vip" },
  { color: "white", style: "sedan", ticket_no: 237, space: "3B7" },
]) 
 
locations[2].vehicles = Vehicle.create([
  { color: "blue", style: "coupe", ticket_no: 521, space: "3A4" },
  { color: "green", style: "sedan", ticket_no: 522, space: "4B12" },
  { color: "yellow", style: "truck", ticket_no: 523, space: "vip" },
  { color: "silver", style: "sedan", ticket_no: 528, space: "3B7" },
]) 
