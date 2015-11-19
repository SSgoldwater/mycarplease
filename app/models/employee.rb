class Employee < ActiveRecord::Base
  validates :first_name, :last_name, :email, :password_digest, presence: true
  enum status: [ :active, :inactive ]
  belongs_to :location
  has_secure_password
  before_save :default_values
   
  def clockin(employee, params)
    if employee.authenticate(params["password"])
      employee.active!
      @response = { employee: employee, 
		    account:  employee.clockin_location(params),
		    vehicles: employee.clockin_location(params).vehicles 
      }
    else
      @response = { error: "Invalid login" }
    end
  end

  def clockin_location(clockin_params)
    Location.find_by(name: clockin_params["account"])
  end
  
  def default_values
    self.status ||= 'inactive'
  end

end
