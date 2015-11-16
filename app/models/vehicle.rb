class Vehicle < ActiveRecord::Base
  belongs_to :location
  belongs_to :customer
  validates :ticket_no, length: { is: 3 }
  validates :space, presence: true
  before_save :default_values
  
  def default_values
    self.status ||= "parked"
  end

end
