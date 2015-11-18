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
    @customer = Customer.find(params[:id])
    customer = @customer
    customer.location = Location.find(params["customer"]["location"])
    if customer.verify(customer, customer_params) 
      customer.vehicle = Vehicle.find_by(ticket_no: params["customer"]["ticket_no"]) 
      customer.vehicle.status = "needs_quote"
      customer.vehicle.save
      customer.update!(customer_params)
      render :final
    else 
      render :get_vehicle
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:phone, :ticket_no, :text_confirmation)
  end

end
