class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end


  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path(@customer.id)
    else
      render :edit
    end
  end

  def withdrawal
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def edit
    @customer = current_customer
    if @customer == current_customer
      render "edit"
    else
      redirect_to customer_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      bypass_sign_in(@customer)
      redirect_to customers_path
    else
      render "edit"
    end
  end

  def comments
    if params[:latest]
      @comments = Comment.latest
    elsif params[:old]
      @comments = Comment.old
    elsif params[:star_count]
      @comments = Comment.star_count
    else
      @comments = Comment.all
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name_kana, :first_name, :last_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
    end
end
