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
    render (@customer.verify(@customer, params, customer_params))
  end

  private

  def customer_params
    params.require(:customer).permit(:phone, :ticket_no, :text_confirmation)
  end

end
