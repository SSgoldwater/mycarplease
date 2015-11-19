class Api::V1::EmployeesController < ApiController
  def clockin
    employee = Employee.find_by(email: params["email"])
    respond_with (employee.clockin(employee, params)), location: root_url
  end
end
