class Employee < ActiveRecord::Base
  enum status: [ :active, :inactive ]
  belongs_to :location
  has_secure_password

  def clockin_location(clockin_params)
    Location.find_by(name: clockin_params["account"])
  end
  
end
