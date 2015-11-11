class Api::V1::EmployeesController < ApplicationController
  respond_to :json, :xml

  def clockin
    employee = Employee.find_by(email: params["email"])
    if employee.authenticate(params["password"])
      employee.status = "active"
      employee.save
      respond_with employee
    end
  end
  
end
