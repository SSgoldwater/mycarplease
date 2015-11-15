class Customer < ActiveRecord::Base
  belongs_to :location
  has_one    :vehicle

  def send_code(phone_number)
    code = "123 456"
    self.text_confirmation = code
    binding.pry
    self.save
    Messenger.send_text(phone_number, code)
  end

  def send_quote(quote)
    binding.pry
    puts quote
  end

  def verify(customer, customer_params)
    if customer.text_confirmation == customer_params[:text_confirmation] 
      true
    end
  end

end
