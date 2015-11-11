class Employee < ActiveRecord::Base
  enum status: [ :active, :inactive ]
  has_secure_password
end
