class Api::V1::EmployeesController < ApiController
  def clockin
    employee = Employee.find_by(email: params["email"])
    if employee.authenticate(params["password"])
      employee.active!
      account = employee.clockin_location(params)
      
      @response = { employee: employee, 
		    account: account,
		    vehicles: account.vehicles 
      }

      respond_with @response, location: root_url
    end
  end
  
end
