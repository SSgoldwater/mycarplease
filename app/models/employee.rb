class Employee < ActiveRecord::Base
  enum status: [ :active, :inactive ]
  belongs_to :location
  has_secure_password
end
