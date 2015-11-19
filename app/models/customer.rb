class Customer < ActiveRecord::Base
  belongs_to :location
  has_one    :vehicle
  validates  :phone, length: { is: 10 }

  def send_code(phone_number)
    code = (1000..9999).to_a.sample
    self.text_confirmation = code
    self.save
    Messenger.send_code(phone_number, code)
  end

  def send_quote(quote)
    Messenger.send_quote(self.phone, quote)
  end

  def verify(customer, params, customer_params)
    if customer.text_confirmation == customer_params[:text_confirmation].to_i
      customer.location = Location.find(params["customer"]["location"])
      customer.vehicle = Vehicle.find_by(ticket_no: params["customer"]["ticket_no"]) 
      customer.save!
      customer.vehicle.status = "needs_quote"
      customer.vehicle.save
      customer.update!(customer_params)
      :final
    else
      :get_vehicle
    end
  end

end
