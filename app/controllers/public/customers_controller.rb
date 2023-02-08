class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
      if @customer == current_customer
            render "edit"
      else
            redirect_to customer_path
      end
  end

  def withdrawal
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_path
  end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name_kana,:first_name, :last_name_kana,:email, :postal_code,:address, :telephon_number, :is_deleted )
  end

end