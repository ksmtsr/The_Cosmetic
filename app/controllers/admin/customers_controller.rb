class Admin::CustomersController < ApplicationController

  def new
    @customers = Customer.new
  end

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    bypass_sign_in(@customer)
    redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def comments
    @comments = Comment.all
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :last_name_kana, :first_name_kana, :email, :postal_code,:address, :telephone_number, :is_deleted)
  end

end
