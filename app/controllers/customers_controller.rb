class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(phone: customer_params[:phone])

    render :get_vehicle
  end

  def update
    customer = Customer.find(params[:id])
    customer.location = Location.find_by(name: params["customer"]["location"])

    customer.update!(customer_params)
    render :final
  end

  private

  def customer_params
    params.require(:customer).permit(:phone, :ticket_no, :text_confirmation)
  end

end
