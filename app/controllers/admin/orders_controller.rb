class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @total = 0
    @order.shipping_cost = 800
    @order.total_payment = @total + @order.shipping_cost
    @order_history_details = @order.order_history_details
  end

  def order_params
    params.require(:order).permit(:customer_id,
                                  :postal_code,
                                  :address,
                                  :name,
                                  :shipping_cost,
                                  :total_payment,
                                  :payment_method)
  end

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :last_name_kana,
                                     :first_name_kana,
                                     :postal_code,
                                     :address,
                                     :telephone_number,
                                     :email,
                                     :customer_id)
  end

end
