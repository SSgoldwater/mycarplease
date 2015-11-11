class Employee < ActiveRecord::Base
  enum status: [ :active, :inactive ]
  has_one :location, as: :locationable
  has_secure_password
end
