class Employee < ActiveRecord::Base
  validates :first_name, :last_name, :email, :password, presence: true
  enum status: [ :active, :inactive ]
  belongs_to :location
  has_secure_password
  before_save :default_values
   
  def clockin_location(clockin_params)
    Location.find_by(name: clockin_params["account"])
  end
  
  def default_values
    self.status ||= 'inactive'
  end

end
