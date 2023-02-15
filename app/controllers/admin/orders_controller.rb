class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :item_id, :tax_included_price, :amount, :making_status, :payment_method, :status, :image )
  end

end
