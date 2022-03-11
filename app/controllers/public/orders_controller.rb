class Public::OrdersController < ApplicationController

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
      redirect_to order_path(@order.id)
    end
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,
                                  :postal_code,
                                  :address,
                                  :name,
                                  :postage,
                                  :total_amount,
                                  :payment_method)
  end
end
