class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(phone: customer_params[:phone])
    @customer.send_code(params["customer"]["phone"])

    render :get_vehicle
  end

  def update
    customer = Customer.find(params[:id])
    customer.location = Location.find_by(name: params["customer"]["location"])
    binding.pry
    if customer.verify
      customer.vehicle = Vehicle.find_by(ticket_no: params["customer"]["ticket_no"]
    end
    customer.update!(customer_params)
    render :final
  end

  private

  def customer_params
    params.require(:customer).permit(:phone, :ticket_no, :text_confirmation)
  end

end
