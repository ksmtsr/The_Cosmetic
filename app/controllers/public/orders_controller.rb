class Public::OrdersController < ApplicationController

  def new
      @customer = current_customer
      @order = Order.new
  end

  def create
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @order.save
      current_customer.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.amount = cart_item.amount
        @order_detail.tax_included_price = cart_item.item.with_tax_price
        @order_detail.order_id = @order.id
        @order_detail.save
      end
      #注文確定時にカート内を削除
      cart_items = current_customer.cart_items
      cart_items.destroy_all
      redirect_to orders_complete_path
  end



  def confirm
      @order =  Order.new(order_params)
      if params[:order][:select_address] == "1"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.full_name
      end
      @cart_items = current_customer.cart_items
      @customer = current_customer
      @total = 0
  end

  def index
      @orders = current_customer.orders
      @cart_items = CartItem.all
      @total = 0
  end

  def show
      @order = Order.find(params[:id])
      @total = 0
  end




  private


  def order_params
      params.require(:order).permit(:image, :payment_method, :postal_code, :address, :customer_id, :name, :postage, :payment, :order_status)
  end

end
