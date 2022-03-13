class Public::OrdersController < ApplicationController
before_action :authenticate_customer!

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.total_payment = @cart_items.sum(&:subtotal) + @order.shipping_cost
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:address_option] == "my_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address.to_s
      @order.name = current_customer.last_name + current_customer.first_name
    end
    if params[:order][:address_option] == "select_address"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    if params[:order][:address_option] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]


      @address_new = Address.new
      @address_new.postal_code = @order.postal_code
      @address_new.address = @order.address
      @address_new.name = @order.name
      @address_new.customer_id = @order.customer_id
    end
  end

  def complete
  @cart_items = current_customer.cart_items.includes(:item)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'You have created order successfully.'
    end

    @cart_items = current_customer.cart_items.includes(:item)
    @cart_items.each do |cart_item|
    @order_history_details = OrderHistoryDetail.new
    @order_history_details.order_id = @order.id
    @order_history_details.item_id = cart_item.item_id
    @order_history_details.unit_price = cart_item.item.price
    @order_history_details.quantity = cart_item.amount
    @order_history_details.production_status = 0
    @order_history_details.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
    @order.order_history_details.each do |item|
      @total += item.unit_price * item.quantity
      @quantity = item.quantity
      @price = item.unit_price
    end
    @order.shipping_cost = 800
    @order.total_payment = @total + @order.shipping_cost
    @items = Item.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,
                                  :postal_code,
                                  :address,
                                  :name,
                                  :shipping_cost,
                                  :total_payment,
                                  :payment_method)
  end
end
