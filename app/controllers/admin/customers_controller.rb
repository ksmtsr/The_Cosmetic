class Admin::CustomersController < ApplicationController

  def new
    @customers = Customer.new
  end

  def index
    @customers = Customer.all
  end
end
