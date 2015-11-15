class Customer < ActiveRecord::Base
  belongs_to :location
  has_one    :vehicle
  validates  :phone, length: { is: 10 }

  def send_code(phone_number)
    code = "123"
    self.text_confirmation = code
    self.save
    Messenger.send_code(phone_number, code)
  end

  def send_quote(quote)
    Messenger.send_quote(self.phone, quote)
    puts quote
  end

  def verify(customer, customer_params)
    if customer.text_confirmation == customer_params[:text_confirmation].to_i
      true
    end
  end

end
